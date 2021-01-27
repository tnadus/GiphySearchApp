//
//  GiphyDetailViewControllerTests.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import XCTest
@testable import GiphySearchApp

class GiphyDetailViewControllerTests: XCTestCase {
	
	let presenter = GiphyDetailPresenterMock()
	
	func testViewDidLoadShouldCallStart() {
		let sut = createSUT()
		sut.loadViewIfNeeded()
		XCTAssertTrue(presenter.startCalledFlag)
	}
	
	func testUpdateViewShouldUpdateUIOnScreen() {
		let sut = createSUT()
		sut.loadViewIfNeeded()
		
		let titleLabel = "mock-title-label"
		let widthLabel = "mock-width-label"
		let heightLabel = "mock-height-label"
		let giphyDetail = GiphyDetailMock.create()
		
		sut.updateView(titleLabel: titleLabel,
					   widthLabel: widthLabel,
					   heightLabel: heightLabel,
					   giphyDetail: giphyDetail)
		
		XCTAssertEqual(sut.titleLabel.text, titleLabel)
		XCTAssertEqual(sut.titleValueLabel.text, giphyDetail.title)
		XCTAssertEqual(sut.widthLabel.text, widthLabel)
		XCTAssertEqual(sut.widthValueLabel.text, giphyDetail.width)
		XCTAssertEqual(sut.heightLabel.text, heightLabel)
		XCTAssertEqual(sut.heightValueLabel.text, giphyDetail.height)
		XCTAssertNotNil(sut.imgViewFullScreen.image)
	}
	
}

//helpers
extension GiphyDetailViewControllerTests {
	
	func createSUT() -> GiphyDetailViewController {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "GiphyDetailViewControllerId") as GiphyDetailViewController
		vc.presenter = presenter
		return vc
	}
	
	class GiphyDetailPresenterMock: GiphyDetailPresenterProtocol {
		
		var startCalledFlag = false
		
		func start() {
			startCalledFlag = true
		}
		var managedView: GiphyDetailViewProtocol?
	}
	
}
