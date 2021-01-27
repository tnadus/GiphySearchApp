//
//  FlowGiphySearch.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 26/01/2021.
//

import Foundation

/// Flow for the giphySearch scenario
class FlowGiphySearch {
	
	//Properties
	let router: Router
	let moduleFactory: ModuleFactory
	
	/// Initialize the flow
	/// - Parameters:
	///   - router: Router protocol for navigation
	///   - moduleFactory: creates modules
	init(router: Router, moduleFactory: ModuleFactory) {
		self.router = router
		self.moduleFactory = moduleFactory
	}
	
	/// Starts the flow and navigate to the initial screen
	func start() {
		navigateToGiphySearchScreen()
	}
	
	/// Navigates to GiphySearchScreen
	func navigateToGiphySearchScreen() {
		let (vc, navigator) = moduleFactory.makeGiphySearchListModule()
		navigator.onDetailScreen = navigateToGiphyDetailScreen
		router.pushViewController(vc, animated: false)
	}
	
	/// Navigates to GiphyDetailScreen
	/// - Parameter giphyDetail: required detail of the chosen giphy
	func navigateToGiphyDetailScreen(giphyDetail: GiphyDetail) {
		let (vc, _) = moduleFactory.makeGiphyDetailModule(giphyDetail: giphyDetail)
		router.pushViewController(vc, animated: true)
	}
}
