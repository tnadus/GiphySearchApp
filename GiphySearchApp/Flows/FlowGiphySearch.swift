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
		let (vc, _) = moduleFactory.makeGiphySearchListModule()
		router.pushViewController(vc, animated: false)
	}
}
