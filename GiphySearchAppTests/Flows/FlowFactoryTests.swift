//
//  FlowFactoryTests.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import XCTest
@testable import GiphySearchApp

class FlowFactoryTests: XCTestCase {

	let sut = FlowFactory()
	
	func testMakeGiphySearchFlowShouldNotThrowException() {
		let flowGiphySearch = sut.makeGiphySearchFlow(router: UINavigationController(), moduleFactory: ModuleFactory())
		XCTAssertTrue(flowGiphySearch is FlowGiphySearch)
	}


}
