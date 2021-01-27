//
//  GiphyResponse.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation

/// Network response for search request
struct GiphyResponse: Decodable {
	let data: [Giphy]
}
