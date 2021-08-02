//
//  ReviewTableViewCell.swift
//  TV Shows
//
//  Created by Infinum on 28.07.2021..
//

import UIKit
import Kingfisher

class ReviewTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var ratingView: RatingView!
    
    // MARK: - Lifecycle methods -

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
        ratingView.isEnabled = false
        ratingView.configure(withStyle: .small)
        self.selectionStyle = .none
    }
    
    // MARK: - Configure Function
    
    func configure(review: Review) {
        emailLabel.text = review.user.email
        commentLabel.text = review.comment
        ratingView.setRoundedRating(Double(review.rating))
        if let userImageUrl = review.user.imageUrl {
            let placeholder = UIImage(named: "ic-profile-placeholder")
            profileImage.kf.setImage(with: userImageUrl, placeholder: placeholder)
        }
    }

}
