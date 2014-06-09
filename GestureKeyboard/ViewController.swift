//
//  ViewController.swift
//  GestureKeyboard
//
//  Created by Rob Terrell on 6/7/14.
//  Copyright (c) 2014 TouchCentric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        var a = CMUnistrokeGestureRecognizer(target: self, action: "gotGesture:" )

        var aPath = UIBezierPath()
        aPath.moveToPoint( CGPointMake( 0.5, 4.5) )
        aPath.addLineToPoint( CGPointMake( 2.5, 0.5 ) )
        aPath.addLineToPoint( CGPointMake( 4.5, 4.5) )
        aPath.closePath()

        var bPath = UIBezierPath()
        bPath.moveToPoint(    CGPointMake(  1.0, 0.5) )
        bPath.addLineToPoint( CGPointMake(  1.0, 4.5 ) )
        bPath.addLineToPoint( CGPointMake( 1.5, 0.75) )
        bPath.addLineToPoint( CGPointMake( 3.0, 0.5) )
        bPath.addLineToPoint( CGPointMake( 3.5, 1.5) )
        bPath.addLineToPoint( CGPointMake( 2.5, 2) )
        bPath.addLineToPoint( CGPointMake( 1.5, 2.5) )
        bPath.addLineToPoint( CGPointMake( 3.0, 3.0) )
        bPath.addLineToPoint( CGPointMake( 3.5, 4) )
        bPath.addLineToPoint( CGPointMake( 3.0, 4.5) )
        bPath.addLineToPoint( CGPointMake( 2.0, 4.5) )
        bPath.closePath()

        var cPath = UIBezierPath()
        cPath.moveToPoint(    CGPointMake(  4.0, 0.5 ) )
        cPath.addLineToPoint( CGPointMake(  1.0, 1.0 ) )
        cPath.addLineToPoint( CGPointMake(  0.5, 2.0) )
        cPath.addLineToPoint( CGPointMake( 1.0, 4.0) )
        cPath.addLineToPoint( CGPointMake( 3.0, 4.5) )
        cPath.addLineToPoint( CGPointMake( 4, 4) )
        cPath.closePath()

        
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
//        a.registerUnistrokeWithName( "a" , bezierPath: aPath )
//        a.registerUnistrokeWithName( "b" , bezierPath: bPath )
//        a.registerUnistrokeWithName( "c" , bezierPath: cPath )

        self.view.addGestureRecognizer(a)
    }
    
    func gotGesture( r : CMUnistrokeGestureRecognizer ) {
        var path = r.strokePath
        var name = r.result.recognizedStrokeName

        println("gotGesture \(path) \(name)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

