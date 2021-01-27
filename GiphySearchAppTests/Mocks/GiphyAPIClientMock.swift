//
//  GiphyAPIClientMock.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import UIKit
@testable import GiphySearchApp

class GiphyAPIClientMock: GiphyAPIClientProtocol {
	
	var fetchImageCalledFlag = false
	var doSearchCalledFlag = false
	var doSearchSuccessful = true
	var fetchImageSuccessful = true
	
	func fetchImage(urlString: String, onCompletion: @escaping GiphyImageFetchCompletion) {
		fetchImageCalledFlag = true
		if fetchImageSuccessful {
			onCompletion(.success(UIImage(systemName: "circle")!))
		} else {
			onCompletion(.failure(.formatError))
		}
	}
	
	func doSearch(searchTerm: String,
						 limit: String,
						 offset: String,
						 rating: GiphyAPIClient.Rating,
						 lang: GiphyAPIClient.lang,
						 onCompletion: @escaping GiphyAPISearchCompletion
	) {
		doSearchCalledFlag = true
		if doSearchSuccessful {
			onCompletion(.success(GiphyResponse(data: [])))
		} else {
			onCompletion(.failure(.userError))
		}
		
	}
	
}
