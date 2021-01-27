//
//  ImageParser.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import UIKit

struct ImageParser: ParserProtocol {
		
	typealias ParsedData = UIImage
	typealias ParserCompletion = (Result<UIImage, ParseError>) -> Void
	
	func parse(data: Data,
			   onCompletion: @escaping ParserCompletion) {
		if let img = UIImage(data: data) {
			onCompletion(.success(img))
			return
		}
		onCompletion(.failure(.invalid))
	}
}
