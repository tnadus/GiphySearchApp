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
	}

	func makeGiphySearchListModule() -> (GiphySearchListViewController, GiphySearchListPresenter) {
		
		let vc = UIStoryboard(name: Constants.mainBundle, bundle: nil).instantiateViewController(identifier: Constants.giphySearchListId) as GiphySearchListViewController
		let presenter = GiphySearchListPresenter()
		return (vc, presenter)
	}
	
}
