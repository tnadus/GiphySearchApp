//
//  GiphyDetailMock.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import UIKit
@testable import GiphySearchApp

struct GiphyDetailMock {
	static func create() -> GiphyDetail {
		return GiphyDetail(title: "mock-title",
						   width: "mock-width",
						   height: "mock-height",
						   image: UIImage(systemName: "circle")!)
	}
}
