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
	
    override func viewDidLoad() {
        super.viewDidLoad()
		presenter.managedView = self
		presenter.start()
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
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
				searchBar.resignFirstResponder()
			}
		}
	}
}

// MARK: UICollectionViewDataSource
extension GiphySearchListViewController: GiphySearchListViewProtocol {
	
	func updateView(barTitle: String, placeholderText: String) {
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
}


// MARK: UICollectionViewDataSource
extension GiphySearchListViewController: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of items
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
		return cell
	}
}

//MARK: - UIViewCollectionFlowLayoutDelegate
extension GiphySearchListViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: (self.view.frame.width/2.0 - 16), height: 90.0)
	}
}
