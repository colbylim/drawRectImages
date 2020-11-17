//
//  MyView.swift
//  drawRectImages
//
//  Created by colbylim on 2020/11/17.
//

import UIKit

class MyView: UIView {

    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        backgroundColor = UIColor.random
        backgroundColor?.setFill()
        ctx.fill(rect)
    }
}
