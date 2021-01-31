//
//  GiphyImages.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation

/// Nested class for search request response object
struct GiphyImages: Decodable {
	let original: GiphyImage
	let previewGif: GiphyImage
	
	enum CodingKeys: String, CodingKey {
		case original = "original"
		case previewGif = "preview_gif"
	}
}
