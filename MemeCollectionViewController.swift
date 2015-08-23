//
//  MemeCollectionViewController.swift
//  Meme_2
//
//  Created by Jing Jia on 6/21/15.
//  Copyright (c) 2015 Jing Jia. All rights reserved.
//

import Foundation

import UIKit

class MemeCollectionViewController: UICollectionViewController,UICollectionViewDataSource,UINavigationControllerDelegate, UICollectionViewDelegate{


    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    var memes : [Meme]!
    
    // MARK: Table View Data Source
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension1 = (self.view.frame.size.width - (2 * space)) / 3.0
        let dimension2 = (self.view.frame.size.height - (3 * space))/3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension1, dimension2)
    }
        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       self.tabBarController?.tabBar.hidden = false
     
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        self.collectionView!.reloadData()
        

    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[indexPath.row]
    
        cell.imageView?.image = meme.memedImage
     
        return cell
    }


    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
}
