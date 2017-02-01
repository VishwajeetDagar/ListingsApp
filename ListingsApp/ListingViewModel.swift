//
//  ListingViewModel.swift
//  ListingsApp
//
//  Created by Vishwajeet Dagar on 1/25/17.
//  Copyright © 2017 Vishwajeet. All rights reserved.
//

import Foundation
import UIKit

class ListingViewModel{
    var data = [DataModel]()

    func loadData (completionClosure: @escaping (_ listingdata: [DataModel]?)->()){
        if let url=URL(string: "https://www.makaan.com/shade/app/v1/serp/buy?paging=1,20"){
            let downloadGroup = DispatchGroup() // 2

            DispatchQueue.global(qos: .utility).async {
                print("Utility running")
            NetworkUtil().query(url: url, networkClosure: {(data :Data?)->() in
                do{
                    if data != nil {
                        if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject] {
                            if let jsondata1 = convertedJsonIntoDict["data"] as? [String: Any]  {
                                if let listings = jsondata1["listings"] as? [[String: AnyObject]]{
                                    for listing in listings{
                                        downloadGroup.enter()
                                        
                                        let imageUrlString = listing["mainImageUrl"]
                                        let imageUrl:URL = URL(string: imageUrlString as! String)!
                                        let imageData:NSData = NSData(contentsOf: imageUrl)!

                                        let photo1 = UIImage(data: imageData as Data)
                                        guard let data1 = DataModel(unit: listing["unitTypeText"] as! String, photo: photo1, descrip: listing["description"] as? String)
                                            else {
                                            fatalError("Unable to instantiate data")
                                            }
                                            self.data+=[data1]
                                        downloadGroup.leave()
                                    }
                                    //DispatchQueue.main.async(execute: self.mytab.reloadData)
                                }
                                
                            }
                            downloadGroup.notify(queue: DispatchQueue.main) {
                                print("Notifying")
                                completionClosure(self.data)
                            }
                            
                        }
                        else{
                            print("Error in data obtained from API")
                        }
                    }
                    else{
                        print("Could not fetch data as network connection is not available")
                        completionClosure(nil)
                    }
                }
                catch let error as NSError {
                    print("Error found\(error.localizedDescription)")
                }
            })
            }
            print("1234")

        }
    }
    
}
