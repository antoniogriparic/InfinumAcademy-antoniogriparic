//
//  ReviewTableViewCell.swift
//  TV Shows
//
//  Created by Infinum on 28.07.2021..
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var ratingView: RatingView!

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
        ratingView.isEnabled = false
        ratingView.configure(withStyle: .small)
    }
    
    func configure(email: String, comment: String, rating: Int) {
        emailLabel.text = email
        commentLabel.text = comment
        ratingView.setRoundedRating(Double(rating))
    }

}
