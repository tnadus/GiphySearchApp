//
//  GiphyImages.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation

/// Nested class for search request response object
struct GiphyImages: Decodable {
	let originalStill: GiphyOriginalStill
	
	enum CodingKeys: String, CodingKey {
		case originalStill = "original_still"
	}
}
