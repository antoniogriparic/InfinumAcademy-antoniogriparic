//
//  TVShowTableViewCell.swift
//  TV Shows
//
//  Created by Infinum on 26.07.2021..
//

import UIKit

class TVShowTableViewCell: UITableViewCell {
    
    @IBOutlet private var showNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with showName: String) {
        showNameLabel.text = showName
    }

}
