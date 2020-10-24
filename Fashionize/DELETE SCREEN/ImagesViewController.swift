//
//  ImagesViewController.swift
//  Fashionize
//
//  Created by Wahj Al-duwaisan on 10/23/20.
//

import UIKit

class ImagesViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var imageName: String!
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
      setupImageView()
    }
    
    private func setupImageView() {
      guard let name = imageName else { return }
      
      if let image = UIImage(named: name) {
        imageView.image = image
      }
    }
    
    
  }
