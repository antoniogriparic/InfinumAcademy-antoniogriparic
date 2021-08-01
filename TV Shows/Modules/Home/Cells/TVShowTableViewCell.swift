//
//  TVShowTableViewCell.swift
//  TV Shows
//
//  Created by Infinum on 26.07.2021..
//

import UIKit
import Kingfisher

class TVShowTableViewCell: UITableViewCell {
    
    @IBOutlet private var showNameLabel: UILabel!
    @IBOutlet private var showImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with show: Show) {
        showNameLabel.text = show.title
        if let showImageUrl = show.imageUrl {
            let placeholder = UIImage(named: "ic-show-placeholder-vertical")
            showImage.kf.setImage(with: showImageUrl, placeholder: placeholder)
        }
    }

    
}
