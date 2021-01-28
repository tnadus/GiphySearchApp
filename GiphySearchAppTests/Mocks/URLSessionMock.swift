//
//  URLSessionMock.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation
@testable import GiphySearchApp

class URLSessionMock: URLSession {
	
	var data: Data?
	var response: URLResponse?
	var error: Error?

	override func dataTask(with urlRequest: URLRequest,
		completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
	
		return URLSessionDataTaskMock {
			completionHandler(self.data, self.response, self.error)
		}
	}
}

class URLSessionDataTaskMock: URLSessionDataTask {
	private let apply: () -> Void

	init(apply: @escaping () -> Void) {
		self.apply = apply
	}
	
	override func resume() {
		apply()
	}
}
