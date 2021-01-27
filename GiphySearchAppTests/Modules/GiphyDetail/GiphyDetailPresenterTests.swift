//
//  GiphyDetailPresenterTests.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import XCTest
@testable import GiphySearchApp

class GiphyDetailPresenterTests: XCTestCase {

	let managedView = GiphyDetailViewControllerMock()
	let giphyDetail = GiphyDetailMock.create()
	
	func testStartUpdateManagedView() {
		let sut = createSUT()
		sut.start()
		XCTAssertTrue(managedView.updateViewCalledFlag)
	}
}

//Helpers
extension GiphyDetailPresenterTests {
	
	func createSUT() -> GiphyDetailPresenter {
		let presenter = GiphyDetailPresenter(giphyDetail: giphyDetail)
		presenter.managedView = managedView
		return presenter
	}	
}
