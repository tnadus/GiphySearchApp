//
//  GiphySearchListViewController.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 26/01/2021.
//

import UIKit

class GiphySearchListViewController: UIViewController {
	
	//Constants
	private enum Constants {
		static let reuseIdentifier = "GiphySearchCollectionCellId"
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
		presenter.managedView = self
		presenter.start()
    }
	
	override func didReceiveMemoryWarning() {
		presenter.onReceivedMemoryWarning()
	}
}

// MARK: UISearchBarDelegate
extension GiphySearchListViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
		presenter.search(term: searchBar.text)
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.isEmpty {
			presenter.handleCancelButtonAction()
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
				searchBar.resignFirstResponder()
			}
		}
	}
}

// MARK: GiphySearchListViewProtocol
extension GiphySearchListViewController: GiphySearchListViewProtocol {
		
	func updateTexts(barTitle: String, placeholderText: String) {
		self.title = barTitle
		searchBar.placeholder = placeholderText
	}
	
	func showSpinner() {
		view.isUserInteractionEnabled = false
		spinner.startAnimating()
	}
	
	func hideSpinner() {
		view.isUserInteractionEnabled = true
		spinner.stopAnimating()
	}
	
	func showAlert(title: String, body: String) {
		let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
		self.present(alertController, animated: true, completion: nil)
	}
	
	func updateView(giphys: [Giphy]) {
		self.giphys = giphys
		collectionView.reloadData()
	}
	
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

// MARK: UICollectionViewDataSource
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

//MARK: - UIViewCollectionFlowLayoutDelegate
extension GiphySearchListViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: (self.view.frame.width/2.0 - 16), height: 90.0)
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
