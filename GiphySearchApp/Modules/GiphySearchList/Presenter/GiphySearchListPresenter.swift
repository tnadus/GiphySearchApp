//
//  GiphySearchCollectionPresenter.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 26/01/2021.
//

import UIKit

/// GiphySearchListView protocol
protocol GiphySearchListViewProtocol: class {
	func updateTexts(barTitle: String,
					placeholderText: String)
	func updateView(giphys: [Giphy])
	func clearCache()
	func showSpinner()
	func hideSpinner()
	func showAlert(title: String, body: String)
}

/// GiphySearchListPresenter protocol
protocol GiphySearchListPresenterProtocol: class {
	func start()
	func search(term: String?)
	func selectItem(giphy: Giphy, img: UIImage)
	func handleCancelButtonAction()
	func fetchImage(urlString: String,
					giphyId: String,
					onCompletion: ((UIImage?) -> Void)?)
	func onReceivedMemoryWarning()
	var managedView: GiphySearchListViewProtocol? { get set }
}

/// GiphySearchListNavigator protocol
protocol GiphySearchListNavigatorProtocol {
	var onDetailScreen: ((GiphyDetail) -> Void)? { get set }
}

/// Holds and handles all the business related logic of Search List screen
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
	var onDetailScreen: ((GiphyDetail) -> Void)?
	
	/// initialize the presenter with dependencies
	/// - Parameter giphyAPIClient: <#giphyAPIClient description#>
	public init(giphyAPIClient: GiphyAPIClientProtocol = GiphyAPIClient()) {
		self.giphyAPIClient = giphyAPIClient
	}
	
	/// Starts the presenter
	func start() {
		managedView?.updateTexts(barTitle: Constants.barTitle,
								placeholderText: Constants.placeholderText)
	}
}

//MARK: GiphySearchListPresenterProtocol
extension GiphySearchListPresenter: GiphySearchListPresenterProtocol {
	
	/// Handles selection of giphy item
	/// - Parameters:
	///   - giphy: requires giphy object
	///   - img: requires img to pass it to detail screen
	func selectItem(giphy: Giphy,
					img: UIImage) {
		let giphyDetail = GiphyDetail(title: giphy.title,
									  width: giphy.images.originalStill.width,
									  height: giphy.images.originalStill.height,
									  image: img)
		onDetailScreen?(giphyDetail)
	}
	
	/// Manages memory management of image cache
	func onReceivedMemoryWarning() {
		managedView?.clearCache()
	}
	
	/// Fetch image from network
	/// - Parameters:
	///   - urlString: required url in string form
	///   - giphyId: id of the giphy object
	///   - onCompletion: called when it's finished with either success or failure
	func fetchImage(urlString: String,
					giphyId: String,
					onCompletion: ((UIImage?) -> Void)? = nil) {
		giphyAPIClient.fetchImage(urlString: urlString) { result in
			switch result {
			case .success(let img):
				onCompletion?(img)
			case .failure(_):
				onCompletion?(nil)
				break
			}
		}
	}
	
	/// Clears all the giphy objects
	func handleCancelButtonAction() {
		managedView?.updateView(giphys: [])
	}
	
	/// Makes a network search
	/// - Parameter term: search keyword to be sent
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
