//
//  GiphySearchCollectionPresenter.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 26/01/2021.
//

import UIKit

protocol GiphySearchListViewProtocol: class {
	func updateTexts(barTitle: String,
					placeholderText: String)
	func updateView(giphys: [Giphy])
	func updateGiphyImage(img: UIImage, giphyId: String)
	func showSpinner()
	func hideSpinner()
	func showAlert(title: String, body: String)
}

protocol GiphySearchListPresenterProtocol: class {
	func start()
	func search(term: String?)
	func handleCancelButtonAction()
	func fetchImage(urlString: String, giphyId: String)
	var managedView: GiphySearchListViewProtocol? { get set }
}

protocol GiphySearchListNavigatorProtocol {
	var onSuccessScreen: (() -> Void)? { get set }
	var onError: ((Error) -> Void)? { get set }
}

class GiphySearchListPresenter: GiphySearchListNavigatorProtocol {
	
	//Constants
	private enum Constants {
		static let barTitle = NSLocalizedString("Giphy Search App", comment: "screen title")
		static let placeholderText = NSLocalizedString("Enter anything to search", comment: "search bar placeholder text")
		
		enum alertError {
			static let title = NSLocalizedString("Error occured", comment: "error alert title")
			static let bodyDefault = NSLocalizedString("Something went wrong", comment: "default error alert body text")
			static let bodyServer = NSLocalizedString("Connection failed", comment: "server error alert body text")
			static let bodyFormat = NSLocalizedString("Data invalid", comment: "data format error alert body text")
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
		managedView?.updateTexts(barTitle: Constants.barTitle,
								placeholderText: Constants.placeholderText)
	}
}

//MARK: GiphySearchListPresenterProtocol
extension GiphySearchListPresenter: GiphySearchListPresenterProtocol {
	
	func fetchImage(urlString: String,
					giphyId: String) {
		giphyAPIClient.fetchImage(urlString: urlString) { [weak self] result in
			switch result {
			case .success(let img):
				self?.managedView?.updateGiphyImage(img: img,
													giphyId: giphyId)
			case .failure(_):
				print("img error")
				break
			}
		}
	}
	
	func handleCancelButtonAction() {
		managedView?.updateView(giphys: [])
	}
	
	func search(term: String?) {
		guard let term = term else { return }
		managedView?.showSpinner()
		giphyAPIClient.doSearch(searchTerm: term) { [weak self] (result) in
			switch result {
			case .success(let giphyResponse):
				self?.handleSearchSuccess(giphyResponse)
			case .failure(let error):
				self?.handleSearchError(error)
			}
			self?.managedView?.hideSpinner()
		}
	}
	
	private func handleSearchSuccess(_ giphyResponse: GiphyResponse) {
		managedView?.updateView(giphys: giphyResponse.data)
	}
	
	private func handleSearchError(_ error: NetworkServiceError) {
		let  title = Constants.alertError.title
		let body: String
		switch error {
		case .serverError(_):
			body = Constants.alertError.bodyServer
		case .formatError:
			body = Constants.alertError.bodyFormat
		default:
			body = Constants.alertError.bodyDefault
		}
		managedView?.showAlert(title: title,
							   body: body)
	}
}
