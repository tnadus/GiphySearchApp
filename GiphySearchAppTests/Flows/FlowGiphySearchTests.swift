//
//  FlowGiphySearchTests.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import XCTest
@testable import GiphySearchApp

class FlowGiphySearchTests: XCTestCase {

	let router = RouterMock()
	let moduleFactory = ModuleFactory()
	
	func testStartShouldNavigateToGiphySearchScreen() {
		let sut = createSUT()
		sut.start()
		XCTAssertTrue(router.pushViewControllerCalledFlag)
		XCTAssertTrue(router.pushedViewController is GiphySearchListViewController)
	}
	
	func testNavigateToGiphyDetailScreenShouldNavigateToGiphyDetailScreen() {
		let sut = createSUT()
		sut.navigateToGiphyDetailScreen(giphyDetail: GiphyDetailMock.create())
		XCTAssertTrue(router.pushViewControllerCalledFlag)
		XCTAssertTrue(router.pushedViewController is GiphyDetailViewController)
	}
}

//helpers
extension FlowGiphySearchTests {
	func createSUT() -> FlowGiphySearch {
		return FlowGiphySearch(router: router, moduleFactory: moduleFactory)
	}
	
	class RouterMock: Router {
		
		var presentCalledFlag = false
		var pushViewControllerCalledFlag = false
		var popViewControllerCalledFlag = false
		
		var presentedViewController: UIViewController?
		var pushedViewController: UIViewController?
		
		func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
			presentCalledFlag = true
			presentedViewController = viewControllerToPresent
		}
		
		func pushViewController(_ viewController: UIViewController, animated: Bool) {
			pushViewControllerCalledFlag = true
			pushedViewController = viewController
		}
		
		func popViewController(animated: Bool) -> UIViewController? {
			popViewControllerCalledFlag = true
			return nil
		}
	}
}
