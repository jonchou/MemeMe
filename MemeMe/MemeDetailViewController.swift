//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Jonathan Chou on 10/12/15.
//  Copyright © 2015 Jonathan Chou. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = meme.memedImage
    }
}
