//
//  File.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation
@testable import GiphySearchApp

class ParserMock: ParserProtocol {
	typealias ParsedData = String
	var parserSuccess = true
	var parsedData = "parsed"
	
	func parse(data: Data,
			   onCompletion: @escaping ParserCompletion) {
		if parserSuccess {
			onCompletion(.success(parsedData))
		} else {
			onCompletion(.failure(.invalid))
		}
	}
}
