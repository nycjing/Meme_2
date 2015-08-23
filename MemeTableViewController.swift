//
//  MemeTableViewController.swift
//  Meme_2
//
//  Created by Jing Jia on 8/14/15.
//  Copyright (c) 2015 Jing Jia. All rights reserved.
//
import UIKit

class MemeTableViewController: UITableViewController,UINavigationControllerDelegate, UITableViewDelegate {
    
    
    var memes : [Meme]!
    
    // MARK: Table View Data Source
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        self.tableView!.reloadData()
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.memes.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> MemeTableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! MemeTableViewCell
        
        let meme = memes[indexPath.row]
        cell.topText.font =
            UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.topText.text = meme.topText
        cell.bottomText.text = meme.bottomText
        cell.memeImage.image = meme.memedImage
       // cell.imageView?.image = meme.memedImage
        //cell.imageView?.image = UIImage(named: meme.imageName as String)
        
        
       // if let detailTextLabel = cell.detailTextLabel {
         //   detailTextLabel.text = meme.bottomText
       // }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}

