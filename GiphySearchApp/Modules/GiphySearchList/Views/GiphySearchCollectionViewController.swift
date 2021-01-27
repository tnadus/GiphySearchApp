//
//  GiphySearchListViewController.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 26/01/2021.
//

import UIKit

private let reuseIdentifier = "GiphySearchCollectionCellId"

class GiphySearchListViewController: UIViewController {
	
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
		cacheImages.removeAllObjects()
	}
}

// MARK: UISearchBarDelegate
extension GiphySearchListViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
		print(searchBar.text)
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

// MARK: UICollectionViewDataSource
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
	
	func updateGiphyImage(img: UIImage,
						  giphyId: String) {
		cacheImages.setObject(img, forKey: giphyId as NSString)
		var indexPath: IndexPath?
		for cell in collectionView.visibleCells {
			if let giphyCell = cell as? GiphySearchCollectionCell,
			   giphyCell.representedIdentifier == giphyId {
				indexPath = collectionView.indexPath(for: cell)
			}
		}
		if let indexPath = indexPath {
			collectionView.reloadItems(at: [indexPath])
		}
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
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GiphySearchCollectionCell else { return UICollectionViewCell() }

		let giphy = giphys[indexPath.row]
		cell.representedIdentifier = giphy.id
		if let img = cacheImages.object(forKey: giphy.id as NSString) {
			cell.imgViewGif.image = img
		} else {
			cell.updateImgWithPlaceholder()
			presenter.fetchImage(urlString: giphy.images.originalStill.url, giphyId: giphy.id)
		}
		
		return cell
	}
}

// MARK: UICollectionViewDataSource
extension GiphySearchListViewController: UICollectionViewDataSourcePrefetching {
	
	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
		for indexPath in indexPaths {
			print(indexPath)
			let giphy = giphys[indexPath.row]
			if (cacheImages.object(forKey: giphy.id as NSString) == nil) {
				presenter.fetchImage(urlString: giphy.images.originalStill.url, giphyId: giphy.id)
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
