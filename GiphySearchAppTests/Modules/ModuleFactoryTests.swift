//
//  ModuleFactoryTests.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import XCTest
@testable import GiphySearchApp

class ModuleFactoryTests: XCTestCase {

	let sut = ModuleFactory()
	
	func testMakeGiphySearchListModuleShouldNotThrowException() {
		let (vc, presenter) = sut.makeGiphySearchListModule()
		XCTAssertTrue(vc is GiphySearchListViewController)
		XCTAssertTrue(presenter is GiphySearchListPresenter)
	}
	
	func testMakeGiphyDetailModuleShouldNotThrowException() {
		let (vc, presenter) = sut.makeGiphyDetailModule(giphyDetail: GiphyDetailMock.create())
		XCTAssertTrue(vc is GiphyDetailViewController)
		XCTAssertTrue(presenter is GiphyDetailPresenter)
	}

}
