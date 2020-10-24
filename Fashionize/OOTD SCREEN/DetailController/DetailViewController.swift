//
//  DetailViewController.swift
//  Fashionize
//
//  Created by Wahj Al-duwaisan on 10/23/20.
//

import UIKit
class DetailViewController:UIViewController {
    var category:ImageCategory?
    var imageName:String?
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CategoryDetail"
        self.updateViewControllerWithDetails()
    }
    
    func updateViewControllerWithDetails() {
        if let selCategory = self.category, let imageTitle = self.imageName {
            self.descriptionLabel.text = selCategory.catDescription
            self.detailImageView.image = UIImage(named: imageTitle)
        }
    }
    
}
