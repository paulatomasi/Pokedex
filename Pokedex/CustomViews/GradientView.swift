//
//  GradientView.swift
//  Pokedex
//
//  Created by Juliano Nardon on 07/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor = .black { didSet { updateColors() }}
    @IBInspectable var startLocation: Double = 0 { didSet { updateLocations() }}
    
//    @IBInspectable var secondColor: UIColor = .white { didSet { updateColors() }}
//    @IBInspectable var secondLocation: Double = 0.3 { didSet { updateLocations() }}
//
//    @IBInspectable var thirdColor: UIColor = .black { didSet { updateColors() }}
//    @IBInspectable var thirdLocation: Double = 0.6 { didSet { updateLocations() }}
    
    @IBInspectable var endColor: UIColor = .white { didSet { updateColors() }}
    @IBInspectable var endLocation: Double = 0.9 { didSet { updateLocations() }}
    
    @IBInspectable var horizontalMode: Bool = false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode: Bool = false { didSet { updatePoints() }}
    
    override public class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    
    func updateLocations() {
        gradientLayer.locations = [
            startLocation as NSNumber,
//            secondLocation as NSNumber,
//            thirdLocation as NSNumber,
            endLocation as NSNumber
        ]
    }
    
    func updateColors() {
        gradientLayer.colors = [
            startColor.cgColor,
//            secondColor.cgColor,
//            thirdColor.cgColor,
            endColor.cgColor
        ]
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}


