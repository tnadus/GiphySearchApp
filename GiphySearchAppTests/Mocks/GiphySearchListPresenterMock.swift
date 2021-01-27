//
//  GiphySearchListPresenterMock.swift
//  GiphySearchAppTests
//
//  Created by Murat Sudan on 27/01/2021.
//

import UIKit
@testable import GiphySearchApp

class GiphySearchListPresenterMock: GiphySearchListPresenterProtocol,
									GiphySearchListNavigatorProtocol
{
	
	var startCalledFlag = false
	
	func start() {
		startCalledFlag = true
	}
	
	func search(term: String?) {
		
	}
	
	func selectItem(giphy: Giphy, img: UIImage) {
		
	}
	
	func handleCancelButtonAction() {
		
	}
	
	func fetchImage(urlString: String, giphyId: String, onCompletion: ((UIImage?) -> Void)?) {
		
	}
	
	func onReceivedMemoryWarning() {
		
	}
	
	var managedView: GiphySearchListViewProtocol?
	
	var onDetailScreen: ((GiphyDetail) -> Void)?
}
