//
//  ImageParser.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import UIKit

/// Parses data into UIImage
struct ImageParser: ParserProtocol {
		
	typealias ParsedData = UIImage
	typealias ParserCompletion = (Result<UIImage, ParseError>) -> Void
	
	/// Parses image data
	/// - Parameters:
	///   - data: requires data to parse
	///   - onCompletion: called on completion of parsing
	func parse(data: Data,
			   onCompletion: @escaping ParserCompletion) {
		if let img = UIImage(data: data) {
			onCompletion(.success(img))
			return
		}
		onCompletion(.failure(.invalid))
	}
}
