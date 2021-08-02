//
//  TVShowTableViewCell.swift
//  TV Shows
//
//  Created by Infinum on 26.07.2021..
//

import UIKit
import Kingfisher

class TVShowTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private var showNameLabel: UILabel!
    @IBOutlet private var showImage: UIImageView!

    // MARK: - Lifecycle Methods -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Configure function
    
    func configure(with show: Show) {
        showNameLabel.text = show.title
        if let showImageUrl = show.imageUrl {
            let placeholder = UIImage(named: "ic-show-placeholder-vertical")
            showImage.kf.setImage(with: showImageUrl, placeholder: placeholder)
        }
    }

    
}
