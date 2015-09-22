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
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(), //TODO: Fill in appropriate UIColor,
        NSForegroundColorAttributeName : UIColor.whiteColor(), //TODO: Fill in UIColor,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0//TODO: Fill in appropriate Float
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerView.contentMode = UIViewContentMode.ScaleAspectFill
        //set text attributes
        initializeTextField(topTextField, myText: "TOP")
        initializeTextField(bottomTextField, myText: "BOTTOM")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    // Initializes the text field to default attributes
    func initializeTextField(myTextField: UITextField, myText: String) {
        myTextField.defaultTextAttributes = memeTextAttributes
        myTextField.text = myText
        myTextField.textAlignment = NSTextAlignment.Center
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
        } else {
                print("Was not able to assign image")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Dismiss the view controller when user clicks cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

