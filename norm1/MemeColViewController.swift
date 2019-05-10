//
//  MemeColViewController.swift
//  norm1
//
//  Created by Gabriel Patterson on 5/5/19.
//  Copyright © 2019 Gabounet. All rights reserved.
//

import UIKit
class MemeColViewController: UICollectionViewController {
    

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("colcount:",appDelegate.memes.count)
        return appDelegate.memes.count
        
    }
    override func viewWillAppear(_ animated: Bool) {
//to reload the memes in case there is new data
        self.collectionView?.reloadData()
    }
    //present the controller and start the app as if it was Meme1.0
    @IBAction func goToMemeViewController(_ sender: AnyObject) {

        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeController") as! MemeViewController
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        //let villain = self.allVillains[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        //cell.nameLabel.text = "villain.name"
        //cell.villainImageView?.image = UIImage(named: "Phoenix")
        //cell.schemeLabel.text = "Scheme: \(villain.evilScheme)"
        
        let imageView=cell.viewWithTag(2) as! UIImageView
        let tview=cell.viewWithTag(1) as! UILabel
        //cell.imageView?.image = UIImage(named: villain.imageName)
        imageView.image=appDelegate.memes[indexPath.row].originalImage
        tview.text=appDelegate.memes[indexPath.row].topText
        
        return cell
     
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "OldMeme") as! OldMemeViewController
        detailController.imDUmp = appDelegate.memes[indexPath.row].originalImage
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}
