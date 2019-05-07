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
    
    var pname: [String]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.arrayOfImagesName
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.arrayOfIDs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var ImagesName = appDelegate.arrayOfImagesName
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        //let villain = self.allVillains[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        //cell.nameLabel.text = "villain.name"
        //cell.villainImageView?.image = UIImage(named: "Phoenix")
        //cell.schemeLabel.text = "Scheme: \(villain.evilScheme)"
        
        let imageView=cell.viewWithTag(2) as! UIImageView
        let tview=cell.viewWithTag(1) as! UILabel
        //cell.imageView?.image = UIImage(named: villain.imageName)
        imageView.image=UIImage(named: ImagesName[indexPath.row])
        tview.text=pname[indexPath.row]
        
        return cell
     
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeController") as! MemeViewController
        detailController.imDUmp = UIImage(named: self.pname[indexPath.row])
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}
