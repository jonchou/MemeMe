//
//  MemeClass.swift
//  MemeMe
//
//  Created by Jonathan Chou on 9/22/15.
//  Copyright © 2015 Jonathan Chou. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    var topText: String?
    var botText: String?
    var image: UIImage
    var memedImage: UIImage
    
    init(topText: String, botText: String, image: UIImage, memedImage: UIImage){
        self.topText = topText
        self.botText = botText
        self.image = image
        self.memedImage = memedImage
    }
}
