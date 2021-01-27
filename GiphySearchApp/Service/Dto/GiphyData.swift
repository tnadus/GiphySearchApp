//
//  GiphyData.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import Foundation

struct GiphyData: Decodable {
	let type: String
	let id: String
	let url: String
	let title: String
	let images: GiphyImages
}
