//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Jonathan Chou on 9/29/15.
//  Copyright © 2015 Jonathan Chou. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
}