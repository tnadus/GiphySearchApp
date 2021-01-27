//
//  GiphyDetailPresenter.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation

/// GiphyDetailView Protocol
protocol GiphyDetailViewProtocol: class {
	func updateView(titleLabel: String,
					widthLabel: String,
					heightLabel: String,
					giphyDetail: GiphyDetail)
}

/// GiphyDetailPresenter Protocol
protocol GiphyDetailPresenterProtocol {
	func start()
	var managedView: GiphyDetailViewProtocol? { get set }
}

/// Handles all the business logic for GiphyDetailScreen
class GiphyDetailPresenter: GiphyDetailPresenterProtocol {
	
	//Constants
	private enum Constants {
		static let barTitle = NSLocalizedString("Giphy Detail", comment: "screen title")
		static let titleLabel = NSLocalizedString("title :", comment: "title of  image")
		static let widthLabel = NSLocalizedString("width :", comment: "width of  image")
		static let heightLabel = NSLocalizedString("height :", comment: "height of  image")
	}
	
	let giphyDetail: GiphyDetail
	
	//Properties
	weak var managedView: GiphyDetailViewProtocol?
	
	/// Initialize the presenter
	/// - Parameter giphyDetail: details about the chosen giphy
	public init(giphyDetail: GiphyDetail) {
		self.giphyDetail = giphyDetail
	}
	
	/// Start presenter
	func start() {
		managedView?.updateView(titleLabel: Constants.titleLabel,
								widthLabel: Constants.widthLabel,
								heightLabel: Constants.heightLabel,
								giphyDetail: giphyDetail)
	}
}
