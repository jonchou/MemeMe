//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Jonathan Chou on 9/17/15.
//  Copyright © 2015 Jonathan Chou. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navBar: UINavigationBar!
    
    let memeDelegate = MemeTextFieldDelegate()
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5.0
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // set the content mode to be Aspect Fit
        imagePickerView.contentMode = UIViewContentMode.ScaleAspectFit
        
        // set text attributes
        initializeTextField(topTextField, myText: "TOP")
        initializeTextField(bottomTextField, myText: "BOTTOM")
        
        // disable share button
        shareButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // only enable to the camera button when the device has a camera
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // allows keyboard notifications
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // removes keyboard notifications
        unsubscribeFromKeyboardNotifications()
    }
    
    // initializes the text field to default attributes
    func initializeTextField(myTextField: UITextField, myText: String) {
        myTextField.defaultTextAttributes = memeTextAttributes
        myTextField.text = myText
        myTextField.textAlignment = NSTextAlignment.Center
        myTextField.delegate = memeDelegate
    }
    
    // pick an image from the Photo Library
    @IBAction func pickAnImageFromAlbum (sender: AnyObject) {
        pickFromSource(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    // pick an image from the camera
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        pickFromSource(UIImagePickerControllerSourceType.Camera)
    }
    
    // picks the image from the source provided
    func pickFromSource(theSource: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = theSource
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // once you pick an image, assign it to the UIImageView
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]){
        // unwrapping optional image
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            // enable the share button once an image is successfully assigned
            shareButton.enabled = true
        } else {
                print("Not able to assign image")
        }
        
        // dismiss the picker view
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Dismiss the view controller when user clicks cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // shifts the view frame up when the keyboard shows, only for the bottom text field
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    // shifts the view frame back to origin when the keyboard hides
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
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
        presentViewController(activityController, animated: true, completion: nil)
        activityController.completionWithItemsHandler = {
            activityType, completed, returnedItems, activityError in
            if completed {
                self.save(memedImage)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                print("Did not save meme")
            }
        }
    }

    @IBAction func leaveView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func generateMemedImage() -> UIImage
    {
        // hide toolbar and navigation bar
        toolBar.hidden = true
        navBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // unhide toolbar and navigation bar
        toolBar.hidden = false
        navBar.hidden = false
        
        return memedImage
    }
    
    // saves all meme data, doesn't get used yet
    func save(memedImage: UIImage) {
        let meme = Meme(topText: topTextField.text!, botText: bottomTextField.text!, image: imagePickerView.image!, memedImage: memedImage)
        
        // Add it to the memes array on the Application Delegate
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }

}

