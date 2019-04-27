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
     @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var MemeButton: UIButton!
    
    
    //struct to hold image & text info
    struct Meme{
        var originalImage:UIImage?
        var memedImage:UIImage?
        var topText:String=""
        var bottomText:String=""
    }
    //not complete function to change meme struct values
    func generateMemedImage() -> UIImage {
        //hide toolbar and navigation bar
        self.toolbar.isHidden = true
        //self.navigationBar?.isHidden=true
        //self.MemeButton.isHidden=true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.toolbar.isHidden = false
        //self.navigationBar?.isHidden=false
        //self.MemeButton.isHidden=false
        return memeImage
    }
  
    @IBAction func saveSendMeme(_ sender: Any) {
        let memeImage=generateMemedImage()
        imageView.image=memeImage
    }
    @IBAction func resetView(_ sender: Any) {
        self.imageView.image=nil
        self.bottomTextField.text=nil
        self.topTextField.text=nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imageView.image=UIImage(named: "Nikki")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled=UIImagePickerController.isSourceTypeAvailable(.camera)
        
        //subscribeToKeyboardNotifications()
    }
    
    //to pick up a picture from the photo album
    @IBAction func pickView(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate=self
        pickerController.sourceType = .savedPhotosAlbum
        self.present(pickerController, animated: true, completion: nil)
        
            }
    
    
    //assign the image selected using the photo Album to the imageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageView.image = image
        //let memeImage=generateMemedImage()
        //imageView.image=memeImage
        self.cancelButton.isEnabled=true
        dismiss(animated:true, completion: nil)
        
    }
    
    @IBAction func MemeMe(_ sender: Any) {
        let memeImage=generateMemedImage()
        imageView.image=memeImage
    }
}
