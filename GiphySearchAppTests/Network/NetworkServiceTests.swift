//
//  NetworkServiceTests.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import XCTest
@testable import GiphySearchApp

class NetworkServiceTests: XCTestCase {
	
	let urlSession = URLSessionMock()
	let parser = ParserMock()
	let urlRequest = URLRequest(url: URL(string: "https://google.com")!)
	
	func testDispatchShouldReturnParsedDataWhenItsSuccessful() {

		let sut = NetworkService<ParserMock>(urlSession: urlSession)
		urlSession.data = parser.parsedData.data(using: .utf8)
		urlSession.response = HTTPURLResponse(url: urlRequest.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
		let expect = expectation(description: "dispatch")
		
		sut.dispatch(urlRequest: urlRequest, parser: parser) { result in
			switch result {
			case .success(let parsedData):
				XCTAssertEqual(parsedData, self.parser.parsedData)
				expect.fulfill()
			case .failure(_):
				XCTFail()
			}
		}

		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
	func testDispatchShouldRaiseErrorWhenItsFailed() {

		let sut = NetworkService<ParserMock>(urlSession: urlSession)
		urlSession.data = parser.parsedData.data(using: .utf8)
		urlSession.response = HTTPURLResponse(url: urlRequest.url!, statusCode: 500, httpVersion: nil, headerFields: nil)
		let expect = expectation(description: "dispatch")
		
		sut.dispatch(urlRequest: urlRequest, parser: parser) { result in
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

