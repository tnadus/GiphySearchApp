//
//  GiphySearchCollectionPresenter.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 26/01/2021.
//

import Foundation

protocol GiphySearchListViewProtocol: class {
	func updateView(barTitle: String,
					placeholderText: String)
	func showSpinner()
	func hideSpinner()
	func showAlert(title: String, body: String)
}

protocol GiphySearchListPresenterProtocol: class {
	func start()
	func search(term: String?)
	var managedView: GiphySearchListViewProtocol? { get set }
}

protocol GiphySearchListNavigatorProtocol {
	var onSuccessScreen: (() -> Void)? { get set }
	var onError: ((Error) -> Void)? { get set }
}

class GiphySearchListPresenter: GiphySearchListPresenterProtocol
, GiphySearchListNavigatorProtocol {
	
	//Constants
	private enum Constants {
		static let barTitle = NSLocalizedString("Giphy Search App", comment: "screen title")
		static let placeholderText = NSLocalizedString("Enter anything to search", comment: "search bar placeholder text")
		
		enum alert {
			static let title = NSLocalizedString("Error occured", comment: "error alert title")
			static let body = NSLocalizedString("Something went wrong", comment: "error alert body text")
		}
	}
	
	//Properties
	weak var managedView: GiphySearchListViewProtocol?
	let giphyAPIClient: GiphyAPIClientProtocol
	
	//navigation
	var onSuccessScreen: (() -> Void)?
	var onError: ((Error) -> Void)?
	
	public init(giphyAPIClient: GiphyAPIClientProtocol = GiphyAPIClient()) {
		self.giphyAPIClient = giphyAPIClient
	}
	
	func start() {
		managedView?.updateView(barTitle: Constants.barTitle,
								placeholderText: Constants.placeholderText)
	}
	
	func search(term: String?) {
		guard let term = term else { return }
		giphyAPIClient.doSearch(searchTerm: term) { [weak self] (result) in
			switch result {
			case .success(let giphyResponse):
				print(giphyResponse)
			case .failure(let error):
				let  title, body: String
				switch error {
				case .serverError(let statusCode):
					title = 
				case .formatError:
					
				default:
					
				}
				self?.managedView?.showAlert(title: Constants.alert.title,
									   body: Constants.alert.body)
			}
		}
	}
}
