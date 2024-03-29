//
//  Ext+UIColor.swift
//  drawRectImages
//
//  Created by colbylim on 2020/11/17.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
