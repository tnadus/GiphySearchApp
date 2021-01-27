//
//  Request.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation

/// Http methods
public enum HTTPMethod: String {
	case get = "GET"
}

/// Request Protocol
public protocol RequestProtocol {
	var path: String { get }
	var queryParams: [String: String]? { get }
}

/// Extension of Request protocol to handle default buildURLRequest
extension RequestProtocol {
	
	var method: String { return HTTPMethod.get.rawValue }
	var queryParams: [String: String]? { return nil }
		
	func buildURLRequest(baseURL: String) -> URLRequest? {
		guard var urlComponents = URLComponents(string: baseURL) else { return nil }
		urlComponents.path = "\(urlComponents.path)\(path)"
		if let queryParams = queryParams {
			urlComponents.queryItems = queryParams.map { element in URLQueryItem(name: element.key, value: element.value) }
		}
		guard let url = urlComponents.url else { return nil }
		var request = URLRequest(url: url)
		request.httpMethod = method
		return request
	}
}
