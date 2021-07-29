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
    }
    
    // MARK: - Private Functions
    
    func configure(show: Show?) {
        
        guard let showUnwrapped = show else { return }
        
        let avgRating = showUnwrapped.averageRating ?? 0
        descriptionLabel.text = showUnwrapped.description
        numberOfReviewsLabel.text =
            "\(showUnwrapped.noOfReviews) REVIEWS, \(avgRating) AVERAGE"
        ratingView.setRoundedRating(avgRating)
        
        if let showImageUrl = showUnwrapped.imageUrl {
            let url = URL(string: showImageUrl)
            let placeholder = UIImage(named: "ic-show-placeholder-rectangle")
            showImage.kf.setImage(with: url, placeholder: placeholder)
        }
    }

}
