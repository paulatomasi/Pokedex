//
//  MoveTableViewCell.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 09/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class MoveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    
    func config(with model: Move) {
        // TODO: Fix move name
        nameLabel.text = model.name

        typeImageView.image = model.type.icon
        typeImageView.backgroundColor = model.type.color
    }
}

