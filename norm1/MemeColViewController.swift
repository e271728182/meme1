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
        
        return appDelegate.memes.count
        
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
//to reload the memes in case there is new data
        self.collectionView?.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
   
    //present the controller and start the app as if it was Meme1.0
    @IBAction func goToMemeViewController(_ sender: AnyObject) {

        let memeController = self.storyboard!.instantiateViewController(withIdentifier: "MemeController") as! MemeViewController
        self.navigationController!.pushViewController(memeController, animated: true)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)

        
        let imageView=cell.viewWithTag(2) as! UIImageView
        
        imageView.image=appDelegate.memes[indexPath.row].memedImage
        
        return cell
     
    }
    //to push the MemeViewController view
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let oldMemeController = self.storyboard!.instantiateViewController(withIdentifier: "OldMeme") as! OldMemeViewController
        oldMemeController.imDUmp = appDelegate.memes[indexPath.row].memedImage
        self.navigationController!.pushViewController(oldMemeController, animated: true)
        
    }
    
}
