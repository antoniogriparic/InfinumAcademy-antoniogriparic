//
//  ShowDetailsTableViewCell.swift
//  TV Shows
//
//  Created by Infinum on 28.07.2021..
//

import UIKit
import Kingfisher

class ShowDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var numberOfReviewsLabel: UILabel!
    @IBOutlet private weak var ratingView: RatingView!
    @IBOutlet private weak var showImage: UIImageView!
    
    // MARK: - Lifecycle methods -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingView.isEnabled = false
        self.selectionStyle = .none
    }
    
    // MARK: - Private Functions
    
    func configure(show: Show?) {
        
        guard let show = show else { return }
        
        descriptionLabel.text = show.description
        
        if show.noOfReviews == 0 {
            ratingView.isHidden = true
            numberOfReviewsLabel.text = "No reviews yet."
        }
        else {
            let avgRating = show.averageRating ?? 0
            numberOfReviewsLabel.text =
                "\(show.noOfReviews) REVIEWS, \(avgRating) AVERAGE"
            ratingView.setRoundedRating(avgRating)
        }
        
        if let showImageUrl = show.imageUrl {
            let placeholder = UIImage(named: "ic-show-placeholder-rectangle")
            showImage.kf.setImage(with: showImageUrl, placeholder: placeholder)
        }
    }

}
