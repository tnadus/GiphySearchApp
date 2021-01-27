//
//  GiphySearchRequest.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation

/// Holds related info to make a search request
public struct GiphySearchRequest: RequestProtocol {
		
	public var queryParams: [String : String]?
	public let path = "v1/gifs/search"
	
	public init(queryParams: [String : String]?) {
		self.queryParams = queryParams
	}
}
