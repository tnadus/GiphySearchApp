//
//  FlowGiphySearch.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 26/01/2021.
//

import Foundation

class FlowGiphySearch {
	
	//Properties
	let router: Router
	let moduleFactory: ModuleFactory
	
	init(router: Router, moduleFactory: ModuleFactory) {
		self.router = router
		self.moduleFactory = moduleFactory
	}
	
	func start() {
		navigateToGiphySearchScreen()
	}
	
	func navigateToGiphySearchScreen() {
		let (vc, navigator) = moduleFactory.makeGiphySearchListModule()
		navigator.onDetailScreen = navigateToGiphyDetailScreen
		router.pushViewController(vc, animated: false)
	}
	
	func navigateToGiphyDetailScreen(giphyDetail: GiphyDetail) {
		let (vc, _) = moduleFactory.makeGiphyDetailModule(giphyDetail: giphyDetail)
		router.pushViewController(vc, animated: true)
	}
}
