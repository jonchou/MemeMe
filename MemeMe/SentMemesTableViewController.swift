//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Jonathan Chou on 9/29/15.
//  Copyright © 2015 Jonathan Chou. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    @IBOutlet var myTableView: UITableView!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // reloads the data when adding a new meme
        myTableView!.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell")! as UITableViewCell
        let myMeme = memes[indexPath.row]

        // set the image and text
        cell.imageView?.image = myMeme.memedImage
        cell.textLabel?.text = myMeme.topText! + myMeme.botText!
        
        return cell
    }
}