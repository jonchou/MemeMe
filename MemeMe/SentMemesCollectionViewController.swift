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
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let width = (view.frame.size.width - 2*space) / 3.0
        let height = (view.frame.size.height - 2*space) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(width, height)
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