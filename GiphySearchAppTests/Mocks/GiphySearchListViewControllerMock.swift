//
//  GiphySearchListViewControllerMock.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation
@testable import GiphySearchApp

class GiphySearchListViewControllerMock: GiphySearchListViewProtocol {
	
	var barTitle = ""
	var placeholderText = ""
	var clearCacheCalledFlag = false
	var updateViewGiphysCalledFlag = false
	var showSpinnerCalledFlag = false
	var hideSpinnerCalledFlag = false
	var showAlertCalledFlag = false
	var giphys: [Giphy] = []
	
	func updateTexts(barTitle: String, placeholderText: String) {
		self.barTitle = barTitle
		self.placeholderText = placeholderText
	}
	
	func updateView(giphys: [Giphy]) {
		updateViewGiphysCalledFlag = true
		self.giphys = giphys
	}
	
	func clearCache() {
		clearCacheCalledFlag = true
	}
	
	func showSpinner() {
		showSpinnerCalledFlag = true
	}
	
	func hideSpinner() {
		hideSpinnerCalledFlag = true
	}
	
	func showAlert(title: String, body: String) {
		showAlertCalledFlag = true
	}
}
