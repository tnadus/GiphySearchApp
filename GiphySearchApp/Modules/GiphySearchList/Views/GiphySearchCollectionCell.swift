//
//  GiphySearchCollectionCell.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 26/01/2021.
//

import UIKit

class GiphySearchCollectionCell: UICollectionViewCell {
    
	//IBOutlets
	@IBOutlet weak var imgViewGif: UIImageView!
	
	//properties
	var representedIdentifier: String?
	
	func updateImgWithPlaceholder() {
		imgViewGif.image = UIImage(systemName: "person.fill")
	}
}
