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
    

//Attributes for the meme text
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3,
        NSAttributedString.Key.backgroundColor: UIColor.clear
      
    ]
    
//function when the send button is created
    @IBAction func saveSendMeme(_ sender: Any) {
        let memeImage=generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        
        controller.completionWithItemsHandler = {
            (activityType, complete, returnedItems, activityError ) in
            
            
        }
        present(controller, animated: true, completion: nil)
        //imageView.image=memeImage
    }
    @IBAction func resetView(_ sender: Any) {
        self.imageView.image=nil

        cancelButton.isEnabled=false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.imageView.image=UIImage(named: "Nikki")
        topTextField.defaultTextAttributes = memeTextAttributes
        //self.bottomTextField.text="bottom"
        //self.topTextField.text="top"
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .center
        topTextField.textAlignment = .center
        cancelButton.isEnabled=false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled=UIImagePickerController.isSourceTypeAvailable(.camera)
            subscribeToKeyboardNotifications()
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
    
}

//EXTENSIONS FOR NOTIFICATIONS AND RELATED METHODS

//extension to subsribe to keyboard notifications
extension ViewController{
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }


    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder{
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {

            view.frame.origin.y = 0
    
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
}

//extension for Meme related functions
extension ViewController{
    
    //struct to hold image & text info
    struct Meme{
        var originalImage:UIImage?
        var memedImage:UIImage?
        var topText:String=""
        var bottomText:String=""
    }
    //function to create the Meme
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
    
}
