//
//  OldMemeViewController.swift
//  norm1
//
//  Created by Gabriel Patterson on 5/10/19.
//  Copyright © 2019 Gabounet. All rights reserved.
//

import Foundation
import UIKit

class OldMemeViewController:UIViewController{
    @IBOutlet weak var oldMemeImage: UIImageView!
    
    var imDUmp:UIImage?
    override func viewDidLoad() {
        if (imDUmp != nil){
            self.oldMemeImage.image=imDUmp
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBarController?.tabBar.isHidden = true
     
        
    }
}
