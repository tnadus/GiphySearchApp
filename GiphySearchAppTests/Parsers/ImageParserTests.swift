//
//  ImageParserTests.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import XCTest
@testable import GiphySearchApp

class ImageParserTests: XCTestCase {

	func testParseShouldReturnImageWhenParseIsSuccessful() {
		
		let sut = ImageParser()
		let img = UIImage(systemName: "circle")!
		let data = img.jpegData(compressionQuality: 0)!
		
		let expect = expectation(description: "parsing")
		sut.parse(data: data) { result in
			switch result {
			case .success(let img):
				XCTAssertNotNil(img)
				expect.fulfill()
			case .failure(_):
				XCTFail()
			}
		}
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
	func testParseShouldReturnErrorWhenParseIsFailed() {
		
		let sut = ImageParser()
		let data = "test".data(using: .utf8)!
		
		let expect = expectation(description: "parsing")
		sut.parse(data: data) { result in
			switch result {
			case .success(_):
				XCTFail()
			case .failure(_):
				expect.fulfill()
			}
		}
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
}
