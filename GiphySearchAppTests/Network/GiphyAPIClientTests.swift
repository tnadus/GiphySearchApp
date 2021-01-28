//
//  GiphyAPIClientTests.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 28/01/2021.
//

import XCTest
@testable import GiphySearchApp

class GiphyAPIClientTests: XCTestCase {

	let urlSession = URLSessionMock()
	let urlString = "https://google.com"
	var sut: GiphyAPIClient {
		return GiphyAPIClient(urlSession: urlSession)
	}
	
	func testDoSearchShouldReturnDecodableModelWhenItsSuccessful() {
		let json = "{\"data\" : []}"
		urlSession.data = json.data(using: .utf8)
		urlSession.response = HTTPURLResponse(url: URL(string: urlString)!, statusCode: 200, httpVersion: nil, headerFields: nil)
		
		let expect = expectation(description: "doSearch")
		sut.doSearch(searchTerm: "mock") { (result) in
			switch result {
			case .success(let response):
				XCTAssertNotNil(response)
				expect.fulfill()
			case .failure(_):
				XCTFail()
			}
		}
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
	func testDoSearchShouldRaiseErrorWhenItsFailed() {
		let json = "{\"data\" : []}"
		urlSession.data = json.data(using: .utf8)
		urlSession.response = HTTPURLResponse(url: URL(string: urlString)!, statusCode: 500, httpVersion: nil, headerFields: nil)
		
		let expect = expectation(description: "doSearch")
		sut.doSearch(searchTerm: "mock") { (result) in
			switch result {
			case .success(_):
				XCTFail()
			case .failure(_):
				expect.fulfill()
			}
		}
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
	func testFetchImageShouldReturnImageWhenItsSuccessful() {
		
		urlSession.data = UIImage(systemName: "circle")?.jpegData(compressionQuality: 0.1)
		urlSession.response = HTTPURLResponse(url: URL(string: urlString)!, statusCode: 200, httpVersion: nil, headerFields: nil)
		
		let expect = expectation(description: "fetchImage")
		
		sut.fetchImage(urlString: urlString) { (result) in
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
	
	func testFetchImageShouldRaiseErrorWhenItsFailed() {
		
		urlSession.data = UIImage(systemName: "circle")?.jpegData(compressionQuality: 0.1)
		urlSession.response = HTTPURLResponse(url: URL(string: urlString)!, statusCode: 500, httpVersion: nil, headerFields: nil)
		
		let expect = expectation(description: "fetchImage")
		
		sut.fetchImage(urlString: urlString) { (result) in
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
