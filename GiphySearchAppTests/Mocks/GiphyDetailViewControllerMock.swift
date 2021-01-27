//
//  GiphyDetailViewControllerMock.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation
@testable import GiphySearchApp

class GiphyDetailViewControllerMock: GiphyDetailViewProtocol {
	
	var updateViewCalledFlag = false
	
	func updateView(titleLabel: String, widthLabel: String, heightLabel: String, giphyDetail: GiphyDetail) {
		updateViewCalledFlag = true
	}
}
