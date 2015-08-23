//
//  MemeEditorViewControll.swift
//  Meme_2
//
//  Created by Jing Jia on 6/22/15.
//  Copyright (c) 2015 Jing Jia. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var share: UIBarButtonItem!
    
    @IBOutlet weak var topText1: UITextField!
    
    @IBOutlet weak var bottomText1: UITextField!
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var camera: UIButton!
    
    @IBOutlet weak var photo: UIButton!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName :  UIColor.whiteColor(),
        NSForegroundColorAttributeName : UIColor.blackColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
        NSStrokeWidthAttributeName : 5
    ]
    
    
    //var memedImage: UIImage!
  //  var memes = [Meme]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        topText1.defaultTextAttributes = memeTextAttributes
        bottomText1.defaultTextAttributes = memeTextAttributes
        self.bottomText1.delegate=self
        self.topText1.delegate=self
        
    }
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        let object = UIApplication.sharedApplication().delegate
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let memes = appDelegate.memes
        
        if imageView1.image != nil {
            share.enabled = true
        } else
        {share.enabled = false}
        //self.tabBarController?.tabBar.hidden = true
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func moveKeyboard(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
        
    }
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    
    @IBAction func pickAnImageFromAlbum (sender: AnyObject) {
        

            var imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            
            
            //imag.allowsEditing = false
            self.presentViewController(imag, animated: true, completion: nil)
        
    }
    
     @IBAction func pickAnImageFromCamera (sender: AnyObject) {
            var imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.delegate = self
            self.presentViewController(imagePicker, animated: true, completion: nil)

        
        
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView1.image=chosenImage
        imageView1.contentMode = .ScaleAspectFit
         self.dismissViewControllerAnimated(true, completion: nil)
        
    }
   
  
    
    @IBAction func shareMeme(sender: AnyObject) {
        var topTextStr = topText1.text!
        var img: UIImage = imageView1.image!
        var img1: UIImage = generateMemedImage()
        var bottomTextStr = bottomText1.text!
        
        
        
        var meme = Meme(topText: topText1.text!, bottomText: bottomText1.text!, originalImage: img, memedImage: img1)
        
        // Add it to the memes array in the Application Delegate
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        println(appDelegate.memes.count)
        
        
   //     var shareItems:Array = [topTextStr, img1, bottomTextStr]
         var shareItems:Array = [img1]
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
     
        self.navigationController?.navigationBarHidden = false
        self.tabBarController?.tabBar.hidden = false
        //self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)

    }

    
    override func prefersStatusBarHidden() -> Bool {
        return navigationController?.navigationBarHidden == true
    }

    
    func generateMemedImage() -> UIImage
    {
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
        
        self.tabBarController?.tabBar.hidden = true
        camera.hidden=true
        photo.hidden=true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == true, animated: true)
        
        self.navigationController?.navigationBarHidden = false
        self.tabBarController?.tabBar.hidden = false
        camera.hidden=false
        photo.hidden=false
        return memedImage
    }
    

    
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage {
        
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    

}