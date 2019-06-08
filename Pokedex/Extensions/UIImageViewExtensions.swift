//
//  UIImageViewExtensions.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    func loadImage(from urlString: String) {
        if let url = URL(string: urlString) {
            Nuke.loadImage(with: url, into: self)
        }
    }
}
