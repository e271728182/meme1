//
//  ViewController.swift
//  norm1
//
//  Created by Gabriel Patterson on 4/7/19.
//  Copyright © 2019 Gabounet. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate{

    @IBOutlet weak var topTextField: UITextField!
     @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var bottomTextField: UITextField!
    //struct to hold image & text info
    struct Meme{
        var originalImage:UIImage?
        var memedImage:UIImage?
        var topText:String=""
        var bottomText:String=""
    }
    //not complete function to change meme struct values
    func generateMemedImage() -> UIImage {
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
  


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func pickView(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate=self
        pickerController.sourceType = .savedPhotosAlbum
        self.present(pickerController, animated: true, completion: nil)
        
            }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imagePickerView.image = image
      
        dismiss(animated:true, completion: nil)
    }
    
}
