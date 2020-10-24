//
//  ImageCategory.swift
//  Fashionize
//
//  Created by Wahj Al-duwaisan on 10/23/20.
//

import Foundation

struct CategoryConstants {
    static let category_ID = "cat_id"
    static let category_Description = "cat_description"
    static let category_Name = "cat_name"
    static let category_Items = "cat_items"
}


class ImageCategory {
    let name:String
    let catId:String
    let catDescription:String
    var cayegoryItems:[String] //this will holds the
    init(withInfo infoDict:[String:Any]) {
        self.name = infoDict[CategoryConstants.category_Name] as! String
        self.catId = infoDict[CategoryConstants.category_ID] as! String
        self.catDescription = infoDict[CategoryConstants.category_Description] as! String
        self.cayegoryItems = infoDict[CategoryConstants.category_Items] as! [String]
    }
}
