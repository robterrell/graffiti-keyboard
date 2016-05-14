//
//  KeyboardViewController.swift
//  GestureKeyboardExtension
//
//  Created by Rob Terrell on 6/8/14.
//  Copyright (c) 2014 TouchCentric. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton?
    var drawView : UIView = UIView()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        NSLog("Keyboard View Controller init")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }
    override func viewDidAppear(animated: Bool) {
        NSLog("viewDidAppear \(self.drawView.frame), \(self.drawView.superview?.frame)")
        self.drawView.center = self.view.center
    }

    override func viewDidLoad() {
        NSLog("Keyboard View Conroller viewDidLoad")
        
        super.viewDidLoad()

        NSLog("Keyboard View Conroller view \(self.view)")
		
		self.nextKeyboardButton = UIButton(type:.System)
		guard let nextKeyboardButton = self.nextKeyboardButton else {return}
		
		nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard!", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
		nextKeyboardButton.sizeToFit()
		nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
		nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), forControlEvents: .TouchUpInside)
		
		self.view.addSubview(nextKeyboardButton)
		
		let nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
		let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 7.0)
		self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
	

        drawView.frame = CGRectMake(0, 0, 180, 180)
        drawView.backgroundColor = UIColor.darkGrayColor()
        drawView.center = self.view.center
        drawView.layer.cornerRadius = 5.0
        self.view.addSubview(drawView)

        let drawViewVertConstraint = NSLayoutConstraint(item: self.drawView, attribute: .CenterY, relatedBy: .Equal, toItem: self.drawView.superview, attribute: .CenterY, multiplier: 1.0, constant: 0.0)

        let drawViewHorizConstraint = NSLayoutConstraint(item: self.drawView, attribute: .CenterX, relatedBy: .Equal, toItem: nextKeyboardButton.superview, attribute: .CenterX, multiplier: 1.0, constant: 0.0)

        self.view.addConstraints( [drawViewVertConstraint, drawViewHorizConstraint] )

        let a = CMUnistrokeGestureRecognizer(target: self, action: #selector(KeyboardViewController.gotGesture(_:)) )

		guard let plist = NSBundle.mainBundle().pathForResource("graffiti", ofType: "plist") else {return}
		
		guard let dict = NSDictionary(contentsOfFile: plist) as? Dictionary<String, [String]> else {return}
        
        for (letter, points) in dict {
            let path = UIBezierPath()
            var first = true
            for p in points {
                let cgp = CGPointFromString(p)
                if (first) {
                    path.moveToPoint(cgp)
                    first = false
                } else {
                    path.addLineToPoint(cgp)
                }
            }
            path.closePath();
            a.registerUnistrokeWithName( letter, bezierPath: path)
        }
        
        drawView.addGestureRecognizer(a)
    
    }

    func gotGesture( r : CMUnistrokeGestureRecognizer ) {
        //var path = r.strokePath
        let name = r.result.recognizedStrokeName
        
        print("gotGesture \(name)")
        
        let doc : UIKeyInput = self.textDocumentProxy as UIKeyInput

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

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        let proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton?.setTitleColor(textColor, forState: .Normal)
    }

}
