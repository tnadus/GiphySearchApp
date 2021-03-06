//
//  Parser.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation

/// Parse error
enum ParseError: Error {
	case invalid
}

/// Generic Parser protocol
protocol ParserProtocol {
	typealias ParserCompletion = (Result<ParsedData, ParseError>) -> Void
	associatedtype ParsedData
	
	func parse(data: Data,
			   onCompletion: @escaping ParserCompletion)
}
