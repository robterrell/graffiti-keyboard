//
//  KeyboardViewController.swift
//  GestureKeyboardExtension
//
//  Created by Rob Terrell on 6/8/14.
//  Copyright (c) 2014 TouchCentric. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton
    var drawView : UIView = UIView()

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        NSLog("Keyboard View Controller init")
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        NSLog("Keyboard View Conroller viewDidLoad")
        
        super.viewDidLoad()

        NSLog("Keyboard View Conroller view \(self.view)")
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard!", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
    
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])

        drawView.frame = CGRectMake(120, 30, 360, 360)
        drawView.backgroundColor = UIColor.darkGrayColor()
        drawView.center = self.view.center

//        var drawViewBottomConstraint = NSLayoutConstraint(item: self.drawView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
//        var drawViewCenterConstraint = NSLayoutConstraint(item: self.drawView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
//
//        self.view.addConstraints( [drawViewBottomConstraint, drawViewCenterConstraint] )

        
       self.view.addSubview(drawView)
        
        var letters = [
            "a": [
                CGPointMake(0.5, 4.5),
                CGPointMake(2.5, 0.5),
                CGPointMake(4.5, 4.5)
            ],
            "b": [
                CGPointMake(1.0, 0.5),
                CGPointMake(1.0, 4.5),
                CGPointMake(1.5, 0.75),
                CGPointMake(3.0, 0.5),
                CGPointMake(3.5, 1.5),
                CGPointMake(2.5, 2),
                CGPointMake(1.5, 2.5),
                CGPointMake(3.0, 3.0),
                CGPointMake(3.5, 4),
                CGPointMake(3.0, 4.5),
                CGPointMake(2.0, 4.5)
            ],
            "c": [
                CGPointMake(4.0, 0.5),
                CGPointMake(1.0, 1.0),
                CGPointMake(0.5, 2.0),
                CGPointMake(1.0, 4.0),
                CGPointMake(3.0, 4.5),
                CGPointMake(4, 4)
            ],
            "d": [
                CGPointMake(1.0, 0.75),
                CGPointMake(1.0, 4.5),
                CGPointMake(1.25, 1.0),
                CGPointMake(3.0, 0.5),
                CGPointMake(4.0, 1.0),
                CGPointMake(4.5, 2.5),
                CGPointMake(4.0, 3.5),
                CGPointMake(2.5, 4.5),
                CGPointMake(1.0, 4.5)
            ],
//            " ": [
//                CGPointMake(0.50, 3.0),
//                CGPointMake(0.75, 3.1),
//                CGPointMake(1.00, 3.0),
//                CGPointMake(1.25, 3.1),
//                CGPointMake(1.50, 3.0),
//                CGPointMake(1.75, 3.0),
//                CGPointMake(2.00, 3.1),
//                CGPointMake(2.50, 3.0),
//                CGPointMake(2.75, 3.1),
//                CGPointMake(3.00, 3.0),
//                CGPointMake(3.25, 3.1),
//                CGPointMake(3.50, 3.0),
//                CGPointMake(3.75, 3.1),
//                CGPointMake(4.00, 3.0)
//            ],
            "delete": [
                CGPointMake(4.5, 3.1),
                CGPointMake(3.5, 3.0),
                CGPointMake(2.5, 3.1),
                CGPointMake(1.5, 3.0),
                CGPointMake(0.5, 3.1)
            ]
            
        ]

        var a = CMUnistrokeGestureRecognizer(target: self, action: "gotGesture:" )

        for (letter, points:Array<CGPoint>) in letters {
            var path = UIBezierPath()
            var first = true
            for p in points {
                if (first) {
                    path.moveToPoint(p)
                    first = false
                } else {
                    path.addLineToPoint(p)
                }
            }
            path.closePath();
            a.registerUnistrokeWithName( letter, bezierPath: path)
        }
        
        drawView.addGestureRecognizer(a)
    
    }

    func gotGesture( r : CMUnistrokeGestureRecognizer ) {
        var path = r.strokePath
        var name = r.result.recognizedStrokeName
        
        println("gotGesture \(name)")
        
        var doc : UIKeyInput = self.textDocumentProxy as UIKeyInput

        if name == "delete" {
            doc.deleteBackward()
        } else {
            doc.insertText(name)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
