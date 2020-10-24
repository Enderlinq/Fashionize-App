//
//  ViewController.swift
//  Fashionize
//
//  Created by Wahj Al-duwaisan on 10/23/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var categories = [ImageCategory]() //to hold the data to be displayed
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var menuBtn: UIButton!
    
    let headerReuseId = "TableHeaderViewReuseId"
    
    var Assets: [String] = ["hat 1","hat 2","hat 3","hat 4","hat 5","hat 6",
                            "shirt 1","shirt 2","shirt 3","shirt 4","shirt 5", "shirt 6",
                            "pants 1","pants 2","pants 3","pants 4","pants 5", "pants 6",
                            "shoes 1","shoes 2","shoes 3","shoes 4","shoes 5","shoes 6"]
    
    
    @IBAction func MenuBtnn(_ sender: Any) {
        self.performSegue(withIdentifier: "Menu", sender: self)
    }

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Menu" {
            let vc = segue.destination as! MenuScreen
            
        }
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = "My Best Images"
        // Do any additional setup after loading the view, typically from a nib.
        let headerNib = UINib(nibName: "CustomHeaderView", bundle: nil)
        self.myTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: headerReuseId)
        setupData()
        self.myTableView.reloadData()
        myTableView.backgroundColor = .clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Data initlisers methods
    func setupData() {
        for index in 0..<5 {
            var infoDict = [String:Any]()
            infoDict = dataForIndex(index: index)
            let aCategory = ImageCategory(withInfo: infoDict)
            categories.append(aCategory)
        }
    }
    
    func dataForIndex(index:Int) -> [String:Any] {
        var data = [String:Any]()
        switch index {
        case 0:
            data["cat_name"] = "Featured"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Randomized"
            data["cat_items"] = [Assets.randomElement()]
        case 1:
            data["cat_name"] = "Hats"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Your hat"
            data["cat_items"] = ["hats 1","hats 2","hats 3","hats 4","hats 5","hats 6"]
        case 2:
            data["cat_name"] = "Shirts"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Your shirt"
            data["cat_items"] = ["shirt 1","shirt 2","shirt 3","shirt 4","shirt 5", "shirt 6"]
        case 3:
            data["cat_name"] = "Pants"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Your pants"
            data["cat_items"] = ["pants 1","pants 2","pants 3","pants 4","pants 5", "pants 6"]
        case 4:
            data["cat_name"] = "Shoes"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Your shoes"
            data["cat_items"] = ["shoes 1","shoes 2","shoes 3","shoes 4","shoes 5","shoes 6"]
        default:
            data["cat_name"] = "Featured"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Random pics"
            data["cat_items"] = [Assets.randomElement()]
        }
        return data
    }
    
    //MARK:Tableview Delegates and Datasource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell
        if cell == nil {
            cell = CustomTableViewCell.customCell
            cell?.backgroundColor = .clear
        }
        let aCategory = self.categories[indexPath.section]
        cell?.updateCellWith(category: aCategory)
        cell?.cellDelegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseId) as? CustomHeaderView
        if view == nil {
            view = CustomHeaderView.customView
            view?.backgroundColor = .clear
        }
        let aCategory = self.categories[section]
        view?.headerLabel.text = aCategory.name
        return view
    }
}

extension ViewController:CustomCollectionCellDelegate {
    func collectionView(collectioncell: CustomCollectionViewCell?, didTappedInTableview TableCell: CustomTableViewCell) {
        if let cell = collectioncell, let selCategory = TableCell.aCategory {
            if let imageName = cell.cellImageName {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let detailController = storyBoard.instantiateViewController(withIdentifier:"DetailViewController") as? DetailViewController
                detailController?.category = selCategory
                detailController?.imageName = imageName
                self.navigationController?.pushViewController(detailController!, animated: true)
                
            }
        }
    }
}
 



