//
//  CustomMemeCell.swift
//  MemeMe
//
//  Created by Jonathan Chou on 9/30/15.
//  Copyright © 2015 Jonathan Chou. All rights reserved.
//

import UIKit

class CustomMemeCell: UICollectionViewCell {
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var botLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func setText(topText: String, botText: String) {
        topLabel.text = topText
        botLabel.text = botText
    }
    
    // sets the labels to have the meme font and style
    func setAttributes(topText: String, botText: String, memeAttribText: [String: AnyObject]) {
        var attribText = NSAttributedString(string: topText, attributes: memeAttribText)
        topLabel.attributedText = attribText
        attribText = NSAttributedString(string: botText, attributes: memeAttribText)
        botLabel.attributedText = attribText
    }
}
