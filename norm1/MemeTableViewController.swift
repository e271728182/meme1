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
    print(appDelegate.memes.count)
        return appDelegate.memes.count
    
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    print("ok it Xworks")
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")!

        // Set the name and image
        cell.textLabel?.text = appDelegate.memes[indexPath.row].topText
        cell.imageView?.image = appDelegate.memes[indexPath.row].originalImage
    return cell
    }
    

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeController") as! MemeViewController
        detailController.imDUmp = appDelegate.memes[indexPath.row].originalImage
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    }


