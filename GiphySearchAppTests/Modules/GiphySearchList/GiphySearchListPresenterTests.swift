//
//  GiphySearchListPresenterTests.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import XCTest
@testable import GiphySearchApp

class GiphySearchListPresenterTests: XCTestCase {
	
	let managedView = GiphySearchListViewControllerMock()
	let apiClient = GiphyAPIClientMock()
	
	func testStartShouldUpdateManagedView() {
		let sut = createSUT()
		sut.start()
		XCTAssertEqual(managedView.barTitle, "Giphy Search App")
		XCTAssertEqual(managedView.placeholderText, "Enter anything to search")
	}
	
	func testOnReceivedMemoryWarningShouldClearCache() {
		let sut = createSUT()
		sut.start()
		sut.onReceivedMemoryWarning()
		XCTAssertTrue(managedView.clearCacheCalledFlag)
	}
	
	func testSearchShouldUpdateManageViewWhenItsSuccessful() {
		let sut = createSUT()
		sut.start()
		sut.search(term: "mock")
				
		XCTAssertTrue(apiClient.doSearchCalledFlag)
		XCTAssertTrue(managedView.updateViewGiphysCalledFlag)
		XCTAssertTrue(managedView.showSpinnerCalledFlag)
		XCTAssertTrue(managedView.hideSpinnerCalledFlag)
	}
	
	func testSearchShouldUpdateManageViewWithErrorAlertWhenItsFailed() {
		let sut = createSUT()
		sut.start()
		
		apiClient.doSearchSuccessful = false
		sut.search(term: "mock")
		
		XCTAssertTrue(apiClient.doSearchCalledFlag)
		XCTAssertTrue(managedView.showAlertCalledFlag)
		XCTAssertTrue(managedView.showSpinnerCalledFlag)
		XCTAssertTrue(managedView.hideSpinnerCalledFlag)
	}
	
	func testHandleCancelButtonActionShouldUpdateViewWithEmptyGiphys() {
		let sut = createSUT()
		sut.start()
		sut.handleCancelButtonAction()
		XCTAssertEqual(managedView.giphys.count, 0)
	}
	
	func testSelectItemShouldNavigateToDetailScreen() {
		let sut = createSUT()
		sut.start()
		
		let expect = expectation(description: "navigateToDetailScreen")
		sut.onDetailScreen = { _ in
			expect.fulfill()
		}
		sut.selectItem(giphy: GiphyMock.create(), img: UIImage(systemName: "circle")!)
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
	func testFetchImageShouldReturnImageWhenItsSuccessful() {
		let sut = createSUT()
		sut.start()
		
		let expect = expectation(description: "fetch-image")
		sut.fetchImage(urlString: "mock-url", giphyId: "mock-id") { img in
			XCTAssertNotNil(img)
			expect.fulfill()
		}
			
		XCTAssertTrue(apiClient.fetchImageCalledFlag)
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
	func testFetchImageShouldReturnImageWhenItsFailed() {
		let sut = createSUT()
		sut.start()
		apiClient.fetchImageSuccessful = false
		
		let expect = expectation(description: "fetch-image")
		sut.fetchImage(urlString: "mock-url", giphyId: "mock-id") { img in
			XCTAssertNil(img)
			expect.fulfill()
		}
			
		XCTAssertTrue(apiClient.fetchImageCalledFlag)
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
}

//MARK: Helpers
extension GiphySearchListPresenterTests {
	func createSUT() -> GiphySearchListPresenter {
		let sut = GiphySearchListPresenter(giphyAPIClient: apiClient)
		sut.managedView = managedView
		return sut
	}
}
