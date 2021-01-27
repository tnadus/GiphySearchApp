//
//  JsonParser.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation

/// Parses JSON data into model object
struct JsonParser<CustomData: Decodable>: ParserProtocol {
	
	typealias ParsedData = CustomData
	
	/// Parse json object
	/// - Parameters:
	///   - data: requires Data
	///   - onCompletion: called on completion of parsing
	func parse(data: Data,
			   onCompletion: @escaping ParserCompletion) {
		guard let data = try? JSONDecoder()
				.decode(CustomData.self, from: data) else {
			onCompletion(.failure(.invalid))
			return
		}
		onCompletion(.success(data))
	}
}
