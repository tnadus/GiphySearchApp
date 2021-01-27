//
//  GiphyDetailPresenter.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation

protocol GiphyDetailViewProtocol: class {
	func updateView(titleLabel: String,
					widthLabel: String,
					heightLabel: String,
					giphyDetail: GiphyDetail)
}

protocol GiphyDetailPresenterProtocol {
	func start()
	var managedView: GiphyDetailViewProtocol? { get set }
}

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
	
	public init(giphyDetail: GiphyDetail) {
		self.giphyDetail = giphyDetail
	}
	
	func start() {
		managedView?.updateView(titleLabel: Constants.titleLabel,
								widthLabel: Constants.widthLabel,
								heightLabel: Constants.heightLabel,
								giphyDetail: giphyDetail)
	}
}
