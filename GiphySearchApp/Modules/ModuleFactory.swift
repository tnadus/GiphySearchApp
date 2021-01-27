//
//  ModuleFactory.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 26/01/2021.
//

import UIKit

/// Responsible to setup dependencies and assemble of modules (ViewController + presenter + dependencies)
class ModuleFactory {
	
	//Constants
	private enum Constants {
		static let mainBundle = "Main"
		static let giphySearchListId = "GiphySearchListViewControllerId"
		static let giphyDetailId = "GiphyDetailViewControllerId"
	}
	
	/// Generate the SearchListModule by setting up all the dependencies
	/// - Returns: GiphySearchListViewController & GiphySearchListPresenter
	func makeGiphySearchListModule() -> (GiphySearchListViewController, GiphySearchListPresenter) {
		
		let vc = UIStoryboard(name: Constants.mainBundle, bundle: nil).instantiateViewController(identifier: Constants.giphySearchListId) as GiphySearchListViewController
		let presenter = GiphySearchListPresenter()
		vc.presenter = presenter
		return (vc, presenter)
	}
	
	/// Generate the GiphyDetailModule by setting up all the dependencies
	/// - Parameter giphyDetail: requires details of chosen giphy
	/// - Returns: GiphyDetailViewController & GiphyDetailPresenter
	func makeGiphyDetailModule(giphyDetail: GiphyDetail) -> (GiphyDetailViewController, GiphyDetailPresenter) {
		
		let vc = UIStoryboard(name: Constants.mainBundle, bundle: nil).instantiateViewController(identifier: Constants.giphyDetailId) as GiphyDetailViewController
		let presenter = GiphyDetailPresenter(giphyDetail: giphyDetail)
		vc.presenter = presenter
		return (vc, presenter)
	}
	
}
