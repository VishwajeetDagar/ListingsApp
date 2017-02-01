//
//  DataModel.swift
//  ListingsApp
//
//  Created by Vishwajeet Dagar on 1/25/17.
//  Copyright © 2017 Vishwajeet. All rights reserved.
//

import UIKit

class DataModel{
    
    //MARK: Properties
    
    var unit: String
    var photo: UIImage?
    var descrip: String?
    
    
    init?(unit: String, photo: UIImage?, descrip: String?) {
        
        if unit.isEmpty  {
            return nil
        }
        
        self.unit=unit
        if photo != nil{
            self.photo=photo
        }
        else{
            self.photo=#imageLiteral(resourceName: "ph")
        }
        if descrip != nil{
            self.descrip=descrip
        }
        else{
            self.descrip="No description"
        }
    }
    
}
