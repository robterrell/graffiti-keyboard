//
//  ViewController.swift
//  GestureKeyboard
//
//  Created by Rob Terrell on 6/7/14.
//  Copyright (c) 2014 TouchCentric. All rights reserved.
//

// Note: this is the main view controller for the  app -- NOT for the keyboard.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView : UIImageView

    @IBOutlet var label : UILabel
    
    var plist:String = NSBundle.mainBundle().pathForResource("graffiti", ofType: "plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var a = CMUnistrokeGestureRecognizer(target: self, action: "gotGesture:" )
        var dict = NSDictionary(contentsOfFile: plist) // COMPILER BUG: as Dictionary<String, String[]>
        var keys:[String] = dict.allKeys as! [String]
        
        for letter:String in keys {
            var path = UIBezierPath()
            var first = true
            var points = dict[letter] as! [String]
            for p in points {
                var cgp = CGPointFromString(p)
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

        
        var drawView = UIView() as UIView
        drawView.frame = CGRectMake(0, 0, 120, 120)
        drawView.center = self.view.center
        drawView.center.y = drawView.center.y + 180
        drawView.backgroundColor = UIColor.darkGrayColor()
//        var drawViewBottomConstraint = NSLayoutConstraint(item: self.imageView, attribute: .Top, relatedBy: .Equal, toItem: drawView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
//        self.view.addConstraint( drawViewBottomConstraint )
        
        self.view.addSubview(drawView)
        self.view.addGestureRecognizer(a)
    }
    
    func gotGesture( r : CMUnistrokeGestureRecognizer ) {
        var path = r.strokePath
        var name = r.result.recognizedStrokeName

        print("gotGesture: \(name)")
        
        label.text = label.text + name;
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

