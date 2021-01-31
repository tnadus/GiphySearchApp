//
//  GiphySearchListViewController.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 26/01/2021.
//

import UIKit

/// Shows the Giphy Search List screen
class GiphySearchListViewController: UIViewController {
	
	//Constants
	private enum Constants {
		static let reuseIdentifier = "GiphySearchCollectionCellId"
		enum cell {
			static let width: CGFloat = 90.0
			static let paddingBetweenCells: CGFloat = 16.0
		}
	}
	
	//IBOutlets
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var spinner: UIActivityIndicatorView!
		
	//Properties
	var presenter: GiphySearchListPresenterProtocol!
	private var giphys = [Giphy]()
	private var cacheImages = NSCache<NSString, UIImage>()
		
    override func viewDidLoad() {
        super.viewDidLoad()
		
		(self.collectionView.collectionViewLayout as? GiphySearchCollectionLayout)?.delegate = self
		presenter.managedView = self
		presenter.start()
    }
	
	override func didReceiveMemoryWarning() {
		presenter.onReceivedMemoryWarning()
	}
}

// MARK: UISearchBarDelegate
extension GiphySearchListViewController: UISearchBarDelegate {
	
	/// handles search action
	/// - Parameter searchBar: searchBar itself
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
		presenter.search(term: searchBar.text)
	}
	
	/// handles clear action of the searchBar
	/// - Parameters:
	///   - searchBar: searchBar itself
	///   - searchText: searchText
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.isEmpty {
			presenter.handleCancelButtonAction()
		}
	}
}

// MARK: GiphySearchListViewProtocol
extension GiphySearchListViewController: GiphySearchListViewProtocol {
	
	/// Update the static texts on the screen
	/// - Parameters:
	///   - barTitle: ViewController navigation bar title
	///   - placeholderText: placeholderText for searchBar
	func updateTexts(barTitle: String, placeholderText: String) {
		self.title = barTitle
		searchBar.placeholder = placeholderText
	}
	
	/// Shows the spinner
	func showSpinner() {
		view.isUserInteractionEnabled = false
		spinner.startAnimating()
	}
	
	/// Hides the spinner
	func hideSpinner() {
		view.isUserInteractionEnabled = true
		spinner.stopAnimating()
	}
	
	/// Shows an alert view
	/// - Parameters:
	///   - title: title of the alert
	///   - body: body text of the alert
	func showAlert(title: String, body: String) {
		let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
		self.present(alertController, animated: true, completion: nil)
	}
	
	/// Load and show the giphy objects given
	/// - Parameter giphys: given giphy object
	func updateView(giphys: [Giphy]) {
		(collectionView.collectionViewLayout as? GiphySearchCollectionLayout)?.clearCache()
		self.giphys = giphys
		collectionView.reloadData()
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			self.searchBar.resignFirstResponder()
		}
	}
	
	/// Clears cahce
	func clearCache() {
		cacheImages.removeAllObjects()
	}
}

// MARK: UICollectionViewDataSource
extension GiphySearchListViewController: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return giphys.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath) as? GiphySearchCollectionCell else { return UICollectionViewCell() }

		let giphy = giphys[indexPath.row]
		cell.representedIdentifier = giphy.id
		if let img = cacheImages.object(forKey: giphy.id as NSString) {
			cell.imgViewGif.image = img
		} else {
			handleEmptyImageCell(cell, giphy: giphy)
		}
		return cell
	}
	
	func handleEmptyImageCell(_ cell: GiphySearchCollectionCell,
							  giphy: Giphy) {
		cell.updateImgWithPlaceholder()
		presenter.fetchImage(urlString: giphy.images.originalStill.url, giphyId: giphy.id) { img in
			if cell.representedIdentifier == giphy.id {
				cell.imgViewGif.image = img
			}
		}
	}
}

// MARK: UICollectionViewDataSourcePrefetching
extension GiphySearchListViewController: UICollectionViewDataSourcePrefetching {

	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
		for indexPath in indexPaths {
			let giphy = giphys[indexPath.row]
			if (cacheImages.object(forKey: giphy.id as NSString) == nil) {
				presenter.fetchImage(urlString: giphy.images.originalStill.url, giphyId: giphy.id, onCompletion: nil)
			}
		}
	}
}

//MARK: - UICollectionViewDelegate
extension GiphySearchListViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let giphy = giphys[indexPath.row]
		if let cell = collectionView.cellForItem(at: indexPath) as? GiphySearchCollectionCell,
		   let img = cell.imgViewGif.image {
			presenter.selectItem(giphy: giphy, img: img)
		}
	}
}

//MARK: - GiphySearchCollectionLayoutDelegate
extension GiphySearchListViewController: GiphySearchCollectionLayoutDelegate {
	
	func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
		let imgWidthStr = giphys[indexPath.row].images.originalStill.width
		let imgHeightStr = giphys[indexPath.row].images.originalStill.height
		
		let imgWidth = CGFloat((imgWidthStr as NSString).floatValue)
		let imgHeight = CGFloat((imgHeightStr as NSString).floatValue)
		
		let ratio = CGFloat(width/imgWidth)
		return ratio * imgHeight
	}
}
