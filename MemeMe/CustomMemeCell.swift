//
//  CustomMemeCell.swift
//  MemeMe
//
//  Created by Jonathan Chou on 9/30/15.
//  Copyright © 2015 Jonathan Chou. All rights reserved.
//

import UIKit

class CustomMemeCell: UICollectionViewCell {

 //   @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var botLabel: UILabel!
    
    func setText(topText: String, botText: String) {
        topLabel.text = topText
        botLabel.text = botText
    }
    
}
