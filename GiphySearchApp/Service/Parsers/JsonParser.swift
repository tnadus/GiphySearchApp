//
//  JsonParser.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation

struct JsonParser<CustomData: Decodable>: ParserProtocol {
	
	typealias ParsedData = CustomData
	
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
