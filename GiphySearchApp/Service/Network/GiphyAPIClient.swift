//
//  GiphyAPIClient.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import UIKit

/// GiphyAPIClient protocol
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

/// Handles default values for GiphyAPIClient
extension GiphyAPIClientProtocol {
	
	//Constants
	private static var limit: String { "20" }
	private static var offset: String { "0" }
	private static var rating: GiphyAPIClient.Rating { .g }
	private static var lang: GiphyAPIClient.lang { .en }
	
	/// Making a network search on giphy API
	/// - Parameters:
	///   - searchTerm: keyword to be searched
	///   - limit: resuls limit, default is 20
	///   - offset: pagination, default is 0
	///   - rating: rating of the images, default is G
	///   - lang: language of the search term, default is English
	///   - onCompletion: called on completion of search op
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

/// Network API client for Giphy APIs
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
	
	//private vars
	private let urlSession: URLSession
	
	//public types
	public enum Rating: String {
		case g, pg, pg13, r
	}
	
	public enum lang: String {
		case en, es, de, it, tr
	}
	
	public init(urlSession: URLSession = URLSession.shared) {
		self.urlSession = urlSession
	}
	
	/// Making a network search on giphy API
	/// - Parameters:
	///   - searchTerm: keyword to be searched
	///   - limit: resuls limit
	///   - offset: pagination
	///   - rating: rating of the images
	///   - lang: language of the search term
	///   - onCompletion: called on completion of search op
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
		
		let networkService = NetworkService<JsonParser<GiphyResponse>>(urlSession: urlSession)
		networkService.dispatch(urlRequest: urlRequest, parser: parser) { (result) in
			switch result {
			case .success(let giphyResponse):
				onCompletion(.success(giphyResponse))
			case .failure(let error):
				onCompletion(.failure(error))
			}
		}
	}
	
	/// Fetches network images
	/// - Parameters:
	///   - urlString: url string to fetch from
	///   - onCompletion: called on completion of fetch op
	public func fetchImage(urlString: String,
						   onCompletion: @escaping GiphyImageFetchCompletion
	) {
		
		let parser = ImageParser()
		let request = GiphyImageRequest()
		guard let urlRequest = request.buildURLRequest(baseURL: urlString) else { return onCompletion(.failure(.formatError))}
		
		let networkService = NetworkService<ImageParser>(urlSession: urlSession)
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
