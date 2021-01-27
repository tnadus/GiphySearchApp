//
//  JsonParserTests.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import XCTest
@testable import GiphySearchApp

class JsonParserTests: XCTestCase {
	
	struct DecodableMock: Decodable {
		let title: String
	}

	func testParseShouldReturnDecodableDataWhenParseIsSuccessful() {
		
		let sut = JsonParser<DecodableMock>()
		let dataStr = "{ \"title\" : \"hey\" }"
		let data = dataStr.data(using: .utf8)!
		
		let expect = expectation(description: "parsing")
		sut.parse(data: data) { result in
			switch result {
			case .success(let mock):
				XCTAssertEqual(mock.title, "hey")
				expect.fulfill()
			case .failure(_):
				XCTFail()
			}
		}
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
	func testParseShouldReturnErrorWhenParseIsFailed() {
		
		let sut = JsonParser<DecodableMock>()
		let dataStr = "{ \"title\" = \"hey\" }"
		let data = dataStr.data(using: .utf8)!
		
		let expect = expectation(description: "parsing")
		sut.parse(data: data) { result in
			switch result {
			case .success(let mock):
				XCTFail()
			case .failure(_):
				expect.fulfill()
			}
		}
		waitForExpectations(timeout: 1.0, handler: nil)
	}
}
