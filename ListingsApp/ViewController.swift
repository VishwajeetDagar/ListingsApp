//
//  ViewController.swift
//  ListingsApp
//
//  Created by Vishwajeet Dagar on 1/25/17.
//  Copyright © 2017 Vishwajeet. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{

    @IBOutlet var mytab: UITableView!
    var listdata:[DataModel]=[DataModel(unit:"Unit Type", photo:nil,descrip: nil)!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight=UITableViewAutomaticDimension
        tableView.estimatedRowHeight=300
        
        getData()
        
        print("View Loaded")
    }

    func getData()->(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            ListingViewModel().loadData(completionClosure: {(listingdata: [DataModel]?)->() in
                if listingdata != nil{
                    print("reloading")
                    self.listdata=listingdata!
                    DispatchQueue.main.async(execute: self.mytab.reloadData)
                }
                else{
                    let alertController = UIAlertController(title: "Network Error!", message:
                        "Could not connect to the internet", preferredStyle: UIAlertControllerStyle.alert)
                    weak var weakSelf = self
                    alertController.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default,handler: {(action: UIAlertAction!) in weakSelf?.getData()}))
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(listdata.count)
        return (listdata.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellidentifier="CustomCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier, for: indexPath) as? CustomCellTableViewCell else {
            fatalError("The dequeued cell is not an instance of CustomCell.")
        }
        let data1 = listdata[indexPath.row]
        
        // Configure the cell...
        cell.unitTypeText.text=data1.unit
        cell.desc.text=data1.descrip
        cell.imagecell.image=data1.photo
        
        
        
        return cell
    }

}

