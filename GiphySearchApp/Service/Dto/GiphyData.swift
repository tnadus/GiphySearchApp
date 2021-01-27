//
//  Giphy.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation

/// Nested class for search request response object
struct Giphy: Decodable {
	let type: String
	let id: String
	let url: String
	let title: String
	let images: GiphyImages
}
