//
//  GiphyDownsized.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import UIKit

/// Nested class for search request response object
struct GiphyOriginalStill: Decodable {
	let height: String
	let width: String
	let url: String
	let size: String
}
