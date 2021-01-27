//
//  ModuleFactory.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 26/01/2021.
//

import UIKit

class ModuleFactory {
	
	//Constants
	private enum Constants {
		static let mainBundle = "Main"
		static let giphySearchListId = "GiphySearchListViewControllerId"
		static let giphyDetailId = "GiphyDetailViewControllerId"
	}

	func makeGiphySearchListModule() -> (GiphySearchListViewController, GiphySearchListPresenter) {
		
		let vc = UIStoryboard(name: Constants.mainBundle, bundle: nil).instantiateViewController(identifier: Constants.giphySearchListId) as GiphySearchListViewController
		let presenter = GiphySearchListPresenter()
		vc.presenter = presenter
		return (vc, presenter)
	}
	
	func makeGiphyDetailModule() -> (GiphyDetailViewController, GiphyDetailPresenter) {
		
		let vc = UIStoryboard(name: Constants.mainBundle, bundle: nil).instantiateViewController(identifier: Constants.giphyDetailId) as GiphyDetailViewController
		let presenter = GiphyDetailPresenter(giphyDetail: GiphyDetail(title: "", width: "", height: "", image: UIImage()))
		//vc.presenter = presenter
		return (vc, presenter)
	}
	
}
