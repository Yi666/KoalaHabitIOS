//
//  DrawLines.swift
//  Koala2018
//
//  Created by Yi Liu on 2/13/18.
//  Copyright © 2018 Yi Liu. All rights reserved.
//

import UIKit

class DrawLines: UIView {


        override func draw(_ rect: CGRect) {
            //draw lines
            let context = UIGraphicsGetCurrentContext()
            context?.setLineWidth(1.0)
          
            context?.setStrokeColor(UIColor.gray.cgColor)
            context?.move(to: CGPoint(x: 16, y: 111))
            context?.addLine(to: CGPoint(x: 359, y: 111))
            context?.move(to: CGPoint(x: 16, y: 141))
            context?.addLine(to: CGPoint(x: 359, y: 141))
            context?.move(to: CGPoint(x: 16, y: 171))
            context?.addLine(to: CGPoint(x: 359, y: 171))
            context?.move(to: CGPoint(x: 16, y: 201))
            context?.addLine(to: CGPoint(x: 359, y: 201))
            context?.move(to: CGPoint(x: 16, y: 231))
            context?.addLine(to: CGPoint(x: 359, y: 231))
            context?.move(to: CGPoint(x: 16, y: 261))
            context?.addLine(to: CGPoint(x: 359, y: 261))
            context?.move(to: CGPoint(x: 16, y: 291))
            context?.addLine(to: CGPoint(x: 359, y: 291))
            context?.move(to: CGPoint(x: 16, y: 321))
            context?.addLine(to: CGPoint(x: 359, y: 321))
            context?.move(to: CGPoint(x: 16, y: 351))
            context?.addLine(to: CGPoint(x: 359, y: 351))
            context?.move(to: CGPoint(x: 16, y: 351))
            context?.addLine(to: CGPoint(x: 359, y: 351))
            context?.move(to: CGPoint(x: 16, y: 381))
            context?.addLine(to: CGPoint(x: 359, y: 381))
            context?.move(to: CGPoint(x: 16, y: 411))
            context?.addLine(to: CGPoint(x: 359, y: 411))
            context?.strokePath()
        }
        


}
