//
//  ViewController.swift
//  MemeMe
//
//  Created by Jonathan Chou on 9/17/15.
//  Copyright © 2015 Jonathan Chou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(), //TODO: Fill in appropriate UIColor,
        NSForegroundColorAttributeName : UIColor.whiteColor(), //TODO: Fill in UIColor,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0//TODO: Fill in appropriate Float
    ]
    let memeDelegate = MemeTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerView.contentMode = UIViewContentMode.ScaleAspectFit
        //set text attributes
        initializeTextField(topTextField, myText: "TOP")
        initializeTextField(bottomTextField, myText: "BOTTOM")
        //disable share button
        shareButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    // Initializes the text field to default attributes
    func initializeTextField(myTextField: UITextField, myText: String) {
        myTextField.defaultTextAttributes = memeTextAttributes
        myTextField.text = myText
        myTextField.textAlignment = NSTextAlignment.Center
        myTextField.delegate = memeDelegate
    }
    
    // Pick an image from the Photo Library
    @IBAction func pickAnImageFromAlbum (sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Pick an image from the camera
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Once you pick an image, assign it to the UIImageView
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickerView.image = image
            //also enable the share button
            shareButton.enabled = true
        } else {
                print("Was not able to assign image")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Dismiss the view controller when user clicks cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // shifts the view frame up when the keyboard shows
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    // shifts the view frame back down when the keyboard hides
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    // returns the height of the keyboard
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    // allows for the view controller to see the event notification for when the keyboard will hide or show
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // stops seeing the event notification for when the keyboard will show or hide
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)

    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        self.presentViewController(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler = {
            activityType, completed, returnedItems, activityError in
            
            if completed {
                self.save(memedImage)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                print("Unable to save meme")
            }
        }
    }
    // saves all meme data, doesn't get used yet
    func save(memedImage: UIImage) {
        let meme = Meme(topText: topTextField.text!, botText: bottomTextField.text!, image: imagePickerView.image!, memedImage: memedImage)
    }

    func generateMemedImage() -> UIImage
    {
        // hide toolbar and navigation bar
        toolBar.hidden = true
        navBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // unhide toolbar and navigation bar
        toolBar.hidden = false
        navBar.hidden = false
        
        return memedImage
    }

}

