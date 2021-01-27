//
//  NetworkService.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation

enum NetworkServiceError: Error {
	case userError
	case serverError(Int?)
	case formatError
}

protocol NetworkServiceProtocol {
	associatedtype AnyParser: ParserProtocol
	typealias NetworkServiceCompletion = (Result<AnyParser.ParsedData, NetworkServiceError>) -> Void
	
	func dispatch(urlRequest: URLRequest,
				 parser: AnyParser,
				 onCompletion: @escaping NetworkServiceCompletion)
	
	func cancel()
}


class NetworkService<T: ParserProtocol>: NetworkServiceProtocol {
	typealias AnyParser = T
	
	let urlSession: URLSession
	var task: URLSessionDataTask?
	
	public init(urlSession: URLSession = .shared) {
		self.urlSession = urlSession
	}
	
	func dispatch(urlRequest: URLRequest,
				 parser: AnyParser,
				 onCompletion: @escaping NetworkServiceCompletion) {
	
		self.task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
			guard error == nil,
				  let data = data,
				  let statusCode = (response as? HTTPURLResponse)?.statusCode,
				  (200...299).contains(statusCode) else {
				onCompletion(.failure(.serverError((response as? HTTPURLResponse)?.statusCode)))
				return
			}
			
			parser.parse(data: data) { result in
				DispatchQueue.main.async {
					switch result {
					case .success(let parsedData):
						onCompletion(.success(parsedData))
					case .failure(_):
						onCompletion(.failure(.formatError))
					}
				}
			}
		}
		task?.resume()
	}
	
	func cancel() {
		task?.cancel()
	}
		
}
