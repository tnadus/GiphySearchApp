//
//  GiphyDetailViewController.swift
//  GiphySearchApp
//
//  Created by Murat Sudan on 27/01/2021.
//

import UIKit

/// The detail screen of the chosen Gifhy
class GiphyDetailViewController: UIViewController {
	
	//IBOutlets
	@IBOutlet weak var imgViewFullScreen: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var widthLabel: UILabel!
	@IBOutlet weak var heightLabel: UILabel!
	@IBOutlet weak var titleValueLabel: UILabel!
	@IBOutlet weak var widthValueLabel: UILabel!
	@IBOutlet weak var heightValueLabel: UILabel!
	
	//Properties
	var presenter: GiphyDetailPresenterProtocol!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		presenter.managedView = self
		presenter.start()
    }
}

// MARK: GiphyDetailViewProtocol
extension GiphyDetailViewController: GiphyDetailViewProtocol {
	
	/// Update the UI elements
	/// - Parameters:
	///   - titleLabel: title label text
	///   - widthLabel: width label text
	///   - heightLabel: height label text
	///   - giphyDetail: giphy detail to fill the image and label values
	func updateView(titleLabel: String,
					widthLabel: String,
					heightLabel: String,
					giphyDetail: GiphyDetail) {
		self.titleLabel.text = titleLabel
		self.widthLabel.text = widthLabel
		self.heightLabel.text = heightLabel
		
		self.titleValueLabel.text = giphyDetail.title
		self.widthValueLabel.text = giphyDetail.width
		self.heightValueLabel.text = giphyDetail.height
		
		self.imgViewFullScreen.image = giphyDetail.image
	}
}
