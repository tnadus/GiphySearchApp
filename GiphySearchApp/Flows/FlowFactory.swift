//
//  FlowFactory.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 26/01/2021.
//

import UIKit

/// Helper protocol to navigationController to be testable
protocol Router {
	func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
	func pushViewController(_ viewController: UIViewController, animated: Bool)
	func popViewController(animated: Bool) -> UIViewController?
}

/// UINavigationController conforms Router protocol
extension UINavigationController: Router { }

/// Creates flow object for each flow screnario
class FlowFactory {
	func makeGiphySearchFlow(router: Router, moduleFactory: ModuleFactory) -> FlowGiphySearch {
		return FlowGiphySearch(router: router, moduleFactory: moduleFactory)
	}
}
