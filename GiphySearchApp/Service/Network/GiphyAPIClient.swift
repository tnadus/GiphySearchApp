//
//  GiphyAPIClient.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import UIKit

protocol GiphyAPIClientProtocol {
	typealias GiphyAPISearchCompletion = (Result<GiphyResponse, NetworkServiceError>) -> Void
	typealias GiphyImageFetchCompletion = (Result<UIImage, NetworkServiceError>) -> Void
	
	func doSearch(searchTerm: String,
						 limit: String,
						 offset: String,
						 rating: GiphyAPIClient.Rating,
						 lang: GiphyAPIClient.lang,
						 onCompletion: @escaping GiphyAPISearchCompletion
						 )
	
	func fetchImage(urlString: String,
					onCompletion: @escaping GiphyImageFetchCompletion)
}

extension GiphyAPIClientProtocol {
	//Constants
	private static var limit: String { "20" }
	private static var offset: String { "0" }
	private static var rating: GiphyAPIClient.Rating { .g }
	private static var lang: GiphyAPIClient.lang { .en }
	
	func doSearch(searchTerm: String,
				  limit: String = Self.limit,
				  offset: String = Self.offset,
				  rating: GiphyAPIClient.Rating = Self.rating,
				  lang: GiphyAPIClient.lang = Self.lang,
						 onCompletion: @escaping GiphyAPISearchCompletion
	) {
		doSearch(searchTerm: searchTerm, limit: limit, offset: offset, rating: rating, lang: lang, onCompletion: onCompletion)
	}
}

class GiphyAPIClient: GiphyAPIClientProtocol {
	
	//Constants
	private enum Constants {
		static let apiKey = "s3aVJu2gUhHHN99LrKsL0Zzp6rM84zqm"
		static let host  = "https://api.giphy.com/"
		
		enum SearchAPI {
			static let key = "api_key"
			static let query = "q"
			static let limit = "limit"
			static let offset = "offset"
			static let rating = "rating"
			static let lang = "lang"
		}
	}
	
	public enum Rating: String {
		case g, pg, pg13, r
	}
	
	public enum lang: String {
		case en, es, de, it, tr
	}
	
	public func doSearch(searchTerm: String,
						 limit: String,
						 offset: String,
						 rating: Rating,
						 lang: lang,
						 onCompletion: @escaping GiphyAPISearchCompletion
						 ) {
				
		let parser = JsonParser<GiphyResponse>()
		let request = GiphySearchRequest(queryParams: [
											Constants.SearchAPI.key : Constants.apiKey,
											Constants.SearchAPI.query : searchTerm,
												  Constants.SearchAPI.limit : limit,
												  Constants.SearchAPI.offset : offset,
												  Constants.SearchAPI.rating : rating.rawValue,
												  Constants.SearchAPI.lang : lang.rawValue])
		
		guard let urlRequest = request.buildURLRequest(baseURL: Constants.host) else {
			onCompletion(.failure(.userError))
			return
		}
		
		let networkService = NetworkService<JsonParser<GiphyResponse>>()
		networkService.dispatch(urlRequest: urlRequest, parser: parser) { (result) in
			switch result {
			case .success(let giphyResponse):
				onCompletion(.success(giphyResponse))
			case .failure(let error):
				onCompletion(.failure(error))
			}
		}
	}
	
	public func fetchImage(urlString: String,
						   onCompletion: @escaping GiphyImageFetchCompletion
	) {
		
		let parser = ImageParser()
		let request = GiphyImageRequest()
		guard let urlRequest = request.buildURLRequest(baseURL: urlString) else { return onCompletion(.failure(.formatError))}
		
		let networkService = NetworkService<ImageParser>()
		networkService.dispatch(urlRequest: urlRequest, parser: parser) { (result) in
			switch result {
			case .success(let img):
				onCompletion(.success(img))
			case .failure(let error):
				onCompletion(.failure(error))
			}
		}
	}
		
}
