//
//  MemeTableViewController.swift
//  norm1
//
//  Created by Gabriel Patterson on 5/6/19.
//  Copyright © 2019 Gabounet. All rights reserved.
//

import UIKit
//class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
class MemeTableViewController: UITableViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
        
    }
   //to push the MemeViewController view
    @IBAction func goToMemeViewController(_ sender: AnyObject) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeController") as! MemeViewController
        self.navigationController!.pushViewController(detailController, animated: true)}
    
    // MARK: Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return appDelegate.memes.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")!
        // Set the name and image
        cell.textLabel?.text = appDelegate.memes[indexPath.row].topText + " " + appDelegate.memes[indexPath.row].bottomText
        cell.imageView?.image = appDelegate.memes[indexPath.row].originalImage
    return cell
        
    }
    
    //present the controller and start the app as if it was Meme1.0
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "OldMeme") as! OldMemeViewController
        detailController.imDUmp = appDelegate.memes[indexPath.row].memedImage
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    }


