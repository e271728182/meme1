//
//  ViewController.swift
//  norm1
//
//  Created by Gabriel Patterson on 4/7/19.
//  Copyright © 2019 Gabounet. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var bottomTextField: UITextField!
    
    
    //Attributes for the meme text
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth: -3,
        .backgroundColor: UIColor.clear
        
    ]
    func configureTextField(_ textField: UITextField,_ textAttribute:[NSAttributedString.Key: Any], text: String){
        textField.text = text
        
        //textField.delegate = textFieldDelegate
        textField.defaultTextAttributes = textAttribute
        textField.textAlignment = .center
    }
    
    //function when the send button is created
    @IBAction func saveSendMeme(_ sender: Any) {
        let memeImage=generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        
        
        activityController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                if self.imageView.image != nil{
                    let meme=Meme(originalImage: self.imageView.image, memedImage:memeImage , topText: self.topTextField?.text ?? "", bottomText: self.bottomTextField?.text ?? "")
                    
                    let object = UIApplication.shared.delegate
                    let appDelegate = object as! AppDelegate
                    appDelegate.memes.append(meme)
                    
                }
                

            }
            
        }
        
        present(activityController, animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func resetView(_ sender: Any) {
        self.imageView.image=nil
        
        cancelButton.isEnabled=false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField(topTextField,memeTextAttributes,text: "TOP")
        configureTextField(bottomTextField,memeTextAttributes,text: "BOTTOM")
        
        cancelButton.isEnabled=false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled=UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        
    }
    
    //this function select image from a sourcetype passed to it
    func selectImageFromSource(origin source:UIImagePickerController.SourceType)
    {
        let pickerController = UIImagePickerController()
        pickerController.delegate=self
        pickerController.sourceType = source
        self.present(pickerController, animated: true, completion: nil)
        
    }
    //to pick up a picture from the photo album
    @IBAction func pickView(_ sender: Any) {
        selectImageFromSource(origin: .savedPhotosAlbum)
        
    }
    //take a picture with the camera
    @IBAction func cameraSelfie(_ sender: Any) {

        selectImageFromSource(origin: .camera)
        
    }
    //assign the image selected using the photo Album to the imageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageView.image = image

        self.cancelButton.isEnabled=true
        dismiss(animated:true, completion: nil)
        
    }
    
}

//EXTENSIONS FOR NOTIFICATIONS AND RELATED METHODS

//extension to subsribe to keyboard notifications
extension MemeViewController{
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
extension MemeViewController{
    
    //struct to hold image & text info

    //function to create the Meme
    func generateMemedImage() -> UIImage {
        //hide toolbar and navigation bar
        self.toolbar.isHidden = true

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
