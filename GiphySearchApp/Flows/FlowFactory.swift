//
//  FlowFactory.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 26/01/2021.
//

import UIKit

protocol Router {
	func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
	func pushViewController(_ viewController: UIViewController, animated: Bool)
	func popViewController(animated: Bool) -> UIViewController?
}


extension UINavigationController: Router { }

class FlowFactory {
	func makeGiphySearchFlow(router: Router, moduleFactory: ModuleFactory) -> FlowGiphySearch {
		return FlowGiphySearch(router: router, moduleFactory: moduleFactory)
	}
}
