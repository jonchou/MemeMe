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
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 14)!,
        NSStrokeWidthAttributeName : -5.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 2.0
        let width = (view.frame.size.width - 2*space) / 3.0
        let height = (view.frame.size.height - 2*space) / 5.0
        
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
        cell.setText(meme.topText!, botText: meme.botText!)
     //   let imageView = UIImageView(image: meme.image)
        //cell.backgroundView?.contentMode = UIViewContentMode.ScaleAspectFit
        cell.imageView.image = meme.image
        
        var attribText = NSAttributedString(string: meme.topText!, attributes: memeTextAttributes)
        cell.topLabel.attributedText = attribText
        
        attribText = NSAttributedString(string: meme.botText!, attributes: memeTextAttributes)
        cell.botLabel.attributedText = attribText
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
    
}