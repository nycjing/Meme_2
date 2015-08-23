//
//  MemeDetailViewController.swift
//  Meme_2
//
//  Created by Jing Jia on 6/21/15.
//  Copyright (c) 2015 Jing Jia. All rights reserved.
//


import UIKit

class MemeDetailViewController : UIViewController {
    
  //  @IBOutlet weak var label1: UILabel!

    
    @IBOutlet weak var imageView: UIImageView!
    
  //  @IBOutlet weak var label2: UILabel!
    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       // self.label1.text! = self.meme.topText
       // self.label2.text! = self.meme.bottomText
        self.tabBarController?.tabBar.hidden = true

        self.imageView!.image = meme.memedImage
         }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    

}