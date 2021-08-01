//
//  ShowDetailsTableViewCell.swift
//  TV Shows
//
//  Created by Infinum on 28.07.2021..
//

import UIKit

class ShowDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var numberOfReviewsLabel: UILabel!
    @IBOutlet private weak var ratingView: RatingView!
    
    // MARK: - Lifecycle methods -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingView.isEnabled = false
    }
    
    // MARK: - Private Functions
    
    func configure(description: String, numberOfReviews: Int, averageRating: Double) {
        descriptionLabel.text = description
        numberOfReviewsLabel.text = "\(numberOfReviews) REVIEWS, \(averageRating) AVERAGE"
        ratingView.setRoundedRating(averageRating)
    }

}
