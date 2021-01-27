//
//  GiphySearchListViewControllerTests.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import XCTest
@testable import GiphySearchApp

class GiphySearchListViewControllerTests: XCTestCase {
	
	let presenter = GiphySearchListPresenterMock()
	
	func testLoadViewShouldStartPresenter() {
		let sut = createSUT()
		sut.loadViewIfNeeded()
		XCTAssertTrue(presenter.startCalledFlag)
	}
	
	func testUpdateTextsShouldUpdateTextOnScreen() {
		let sut = createSUT()
		sut.loadViewIfNeeded()
		let barTitle = "mock-title"
		let placeholder = "mock-placeholder"
		sut.updateTexts(barTitle: barTitle, placeholderText: placeholder)
		XCTAssertEqual(sut.title, barTitle)
		XCTAssertEqual(sut.searchBar.placeholder, placeholder)
	}
	
	func testShowSpinnerShouldShowActivityIndicator() {
		let sut = createSUT()
		sut.loadViewIfNeeded()
		sut.showSpinner()
		XCTAssertFalse(sut.spinner.isHidden)
	}
	
	func testHideSpinnerShouldHideActivityIndicator() {
		let sut = createSUT()
		sut.loadViewIfNeeded()
		sut.hideSpinner()
		XCTAssertTrue(sut.spinner.isHidden)
	}
	
	func testShowAlertShouldShowAlert() {
		let sut = createSUT()
		let nav = UINavigationController.init(rootViewController: sut)
		sut.loadViewIfNeeded()
		sut.showAlert(title: "mock-title", body: "mock-body")
		
		let exp = expectation(description: "show-alert")
		let result = XCTWaiter.wait(for: [exp], timeout: 0.5)
		if result == XCTWaiter.Result.timedOut {
			XCTAssertNotNil(nav.visibleViewController is UIAlertController)
		} else {
			XCTFail("Delay interrupted")
		}
	}
}

//helpers
extension GiphySearchListViewControllerTests {
	
	func createSUT() -> GiphySearchListViewController {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "GiphySearchListViewControllerId") as GiphySearchListViewController
		vc.presenter = presenter
		return vc
	}
}
