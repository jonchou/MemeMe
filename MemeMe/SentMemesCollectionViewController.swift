//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Jonathan Chou on 9/29/15.
//  Copyright © 2015 Jonathan Chou. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    @IBOutlet var myCollectionView: UICollectionView!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // reloads the data when adding a new meme
        myCollectionView!.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as! CustomMemeCell
        let meme = memes[indexPath.item]
       // cell.setText(meme.top, bottomString: meme.bottom)
       // let imageView = UIImageView(image: meme.image)
        //cell.backgroundView = imageView
        cell.memeImageView.image = meme.memedImage
        return cell
    }
    
}