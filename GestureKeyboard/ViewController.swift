//
//  ViewController.swift
//  GestureKeyboard
//
//  Created by Rob Terrell on 6/7/14.
//  Copyright (c) 2014 TouchCentric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView : UIImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var a = CMUnistrokeGestureRecognizer(target: self, action: "gotGesture:" )
        
        var letters = [
            "a": [ CGPointMake( 0.5, 4.5), CGPointMake( 2.5, 0.5 ), CGPointMake( 4.5, 4.5) ],
            "b": [ CGPointMake(  1.0, 0.5), CGPointMake(  1.0, 4.5 ), CGPointMake( 1.5, 0.75), CGPointMake( 3.0, 0.5),
                CGPointMake( 3.5, 1.5), CGPointMake( 2.5, 2), CGPointMake( 1.5, 2.5), CGPointMake( 3.0, 3.0),
                CGPointMake( 3.5, 4), CGPointMake( 3.0, 4.5), CGPointMake( 2.0, 4.5) ],
            "c": [ CGPointMake(  4.0, 0.5 ), CGPointMake(  1.0, 1.0 ), CGPointMake(  0.5, 2.0),
                    CGPointMake( 1.0, 4.0), CGPointMake( 3.0, 4.5), CGPointMake( 4, 4)],
            "d": [ CGPointMake(1.0, 0.75), CGPointMake(1.0, 4.5), CGPointMake(1.25,1.0), CGPointMake(3.0,0.5),
                CGPointMake(4.0, 1.0), CGPointMake(4.5, 2.5), CGPointMake(4.0, 3.5), CGPointMake(2.5, 4.5), CGPointMake(1.0, 4.5)]
            ]

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
    
    func hodor( b : UIButton )
    {
        NSLog("Hodor");
    }
    
    func gotGesture( r : CMUnistrokeGestureRecognizer ) {
        var path = r.strokePath
        var name = r.result.recognizedStrokeName

        println("gotGesture: \(name)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

