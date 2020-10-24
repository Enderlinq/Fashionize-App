//
//  DeleteScreen.swift
//  Fashionize
//
//  Created by Wahj Al-duwaisan on 10/23/20.
//

import UIKit

struct Item {
  var imageName: String
}

var items: [Item] = [Item(imageName: "hats 1"),
                     Item(imageName: "hats 2"),
                     Item(imageName: "hats 3"),
                     Item(imageName: "hats 4"),
                     Item(imageName: "hats 5"),
                     Item(imageName: "hats 6"),
                     Item(imageName: "shirt 1"),
                     Item(imageName: "shirt 2"),
                     Item(imageName: "shirt 3"),
                     Item(imageName: "shirt 4"),
                     Item(imageName: "shirt 5"),
                     Item(imageName: "shirt 6"),
                     Item(imageName: "pants 1"),
                     Item(imageName: "pants 2"),
                     Item(imageName: "pants 3"),
                     Item(imageName: "pants 4"),
                     Item(imageName: "pants 5"),
                     Item(imageName: "pants 6"),
                     Item(imageName: "shoes 1"),
                     Item(imageName: "shoes 2"),
                     Item(imageName: "shoes 3"),
                     Item(imageName: "shoes 4"),
                     Item(imageName: "shoes 5"),
                     Item(imageName: "shoes 6")]

class DeleteScreen: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    enum Mode {
      case view
      case select
    }
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var DeleteCollectionView: UICollectionView!
    let cellIdentifier = "ItemCollectionViewCell"
    let viewImageSegueIdentifier = "viewImageSegueIdentifier"
    
    
    var mMode: Mode = .view {
      didSet {
        switch mMode {
        case .view:
          for (key, value) in dictionarySelectedIndecPath {
            if value {
              DeleteCollectionView.deselectItem(at: key, animated: true)
            }
          }
          
          dictionarySelectedIndecPath.removeAll()
          
          selectBarButton.title = "Select"
          navigationItem.leftBarButtonItem = nil
            DeleteCollectionView.allowsMultipleSelection = false
        case .select:
          selectBarButton.title = "Cancel"
          navigationItem.leftBarButtonItem = deleteBarButton
            DeleteCollectionView.allowsMultipleSelection = true
        }
      }
    }
    
    lazy var selectBarButton: UIBarButtonItem = {
      let barButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(didSelectButtonClicked(_:)))
      return barButtonItem
    }()

    lazy var deleteBarButton: UIBarButtonItem = {
      let barButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didDeleteButtonClicked(_:)))
      return barButtonItem
    }()
    
    var dictionarySelectedIndecPath: [IndexPath: Bool] = [:]
    
    let lineSpacing: CGFloat = 5
    let interItemSpacing: CGFloat = 5
    
    override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      setupBarButtonItems()
      setupCollectionView()
      setupCollectionViewItemSize()
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let item = sender as! Item
      
      if segue.identifier == viewImageSegueIdentifier {
        if let vc = segue.destination as? "OOTD" {
          vc.imageName = item.imageName
        }
      }
    }
    
    private func setupBarButtonItems() {
      navigationItem.rightBarButtonItem = selectBarButton
    }

    private func setupCollectionView() {
      DeleteCollectionView.delegate = self
      DeleteCollectionView.dataSource = self
      let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
      DeleteCollectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupCollectionViewItemSize() {
      let customLayout = CustomLayout()
      DeleteCollectionView.delegate = self
      DeleteCollectionView.collectionViewLayout = customLayout
    }
    
    @objc func didSelectButtonClicked(_ sender: UIBarButtonItem) {
      mMode = mMode == .view ? .select : .view
    }
    
    @objc func didDeleteButtonClicked(_ sender: UIBarButtonItem) {
      var deleteNeededIndexPaths: [IndexPath] = []
      for (key, value) in dictionarySelectedIndecPath {
        if value {
          deleteNeededIndexPaths.append(key)
        }
      }
      
      for i in deleteNeededIndexPaths.sorted(by: { $0.item > $1.item }) {
        items.remove(at: i.item)
      }
      
      DeleteCollectionView.deleteItems(at: deleteNeededIndexPaths)
      dictionarySelectedIndecPath.removeAll()
    }
    
  }

  extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = DeleteScreen.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
      
      cell.imageView.image = UIImage(named: items[indexPath.item].imageName)
      
      return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      switch mMode {
      case .view:
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = items[indexPath.item]
        performSegue(withIdentifier: viewImageSegueIdentifier, sender: item)
      case .select:
        dictionarySelectedIndecPath[indexPath] = true
      }
    }
      
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
      if mMode == .select {
        dictionarySelectedIndecPath[indexPath] = false
      }
    }
    
  }

  extension ViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
      return UIImage(named: items[indexPath.item].imageName)!.size
    }
  }

