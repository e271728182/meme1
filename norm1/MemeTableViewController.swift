//
//  MemeTableViewController.swift
//  norm1
//
//  Created by Gabriel Patterson on 5/6/19.
//  Copyright © 2019 Gabounet. All rights reserved.
//

import UIKit
class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    
    // Get ahold of some villains, for the table
    // This is an array of Villain instances
   
    
    // MARK: Table View Data Source
    

    // MARK: Properties
    
    // Get ahold of some villains, for the table
    // This is an array of Villain instances
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var pname: [String]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.arrayOfIDs
    }
    
    // MARK: Table View Data Source
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.arrayOfIDs.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ImagesName = appDelegate.arrayOfImagesName
    print("ok it works")
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")!

        // Set the name and image
        cell.textLabel?.text = ImagesName[indexPath.row]
        cell.imageView?.image = UIImage(named: ImagesName[indexPath.row])
        
        // If the cell has a detail label, we will put the evil scheme in.
        //if let detailTextLabel = cell.detailTextLabel {
            //detailTextLabel.text = "Scheme: \(villain.evilScheme)"
        return cell
        }
        
    
    }


