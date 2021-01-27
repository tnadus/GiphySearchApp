//
//  GiphyMock.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation
@testable import GiphySearchApp

struct GiphyMock {
	static func create() -> Giphy {
		return Giphy(type: "",
					 id: "mock-id",
					 url: "mock-url",
					 title: "mock-title",
					 images: GiphyImages(originalStill:
												GiphyOriginalStill(height: "120",
																   width: "180",
																   url: "mock-image-url",
																   size: "1000")))
	}
}
