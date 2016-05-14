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
    
    @IBOutlet var imageView : UIImageView?

    @IBOutlet var label : UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
		
		guard let plist = NSBundle.mainBundle().pathForResource("graffiti", ofType: "plist") else {return}
		
        let a = CMUnistrokeGestureRecognizer(target: self, action: #selector(ViewController.gotGesture(_:)) )
		guard let dict = NSDictionary(contentsOfFile: plist) else {return}
		
		for (letter, points) in dict {
            let path = UIBezierPath()
            var first = true
            for p in points as! [String] {
                let cgp = CGPointFromString(p)
                if (first) {
                    path.moveToPoint(cgp)
                    first = false
                } else {
                    path.addLineToPoint(cgp)
                }
            }
            path.closePath();
            a.registerUnistrokeWithName(letter as! String, bezierPath: path)
        }

        
        let drawView = UIView() as UIView
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
        _ = r.strokePath
        let name = r.result.recognizedStrokeName

        print("gotGesture: \(name)")
		
		if let l = label {
			l.text = (l.text ?? "") + name;
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

