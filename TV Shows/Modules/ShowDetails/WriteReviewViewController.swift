//
//  WriteReviewViewController.swift
//  TV Shows
//
//  Created by Infinum on 28.07.2021..
//

import UIKit

protocol WriteReviewViewControllerDelegate: AnyObject {
    func reviewDidPublish()
}

class WriteReviewViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var ratingView: RatingView!
    @IBOutlet private weak var commentTextView: UITextView!
    @IBOutlet private weak var submitButton: UIButton!
    
    // MARK: - Properties
    
    private var showService = ShowService()
    var show: Show? = nil
    weak var delegate: WriteReviewViewControllerDelegate?
    
    // MARK: - Lifecycle methods -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    // MARK: - Actions
    
    @IBAction func submitButtonHandler() {
        guard commentTextView.hasText && ratingView.rating > 0 , let unwrapedShow = show else { return }
        showService.publishReview(
            showId: unwrapedShow.id,
            rating: String(ratingView.rating),
            comment: commentTextView.text) { [weak self] response in
            
            guard let self = self else {return}
            
            switch response.result {
            case .success( _):
                self.dismiss(animated: true, completion: nil)
                self.delegate?.reviewDidPublish()
            case .failure(let error):
                self.showAlter(title: "Review not published")
                print(error)
            }
        }
    }
    
    // MARK: - Private Functions
    
    @objc private func didSelectClose() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setUpUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(didSelectClose)
        )
        navigationItem.title = "Write a Review"
        
        commentTextView.text = "Enter your comment here..."
        commentTextView.textColor = .lightGray
        submitButton.layer.cornerRadius = 21.5
    }
    
}

extension WriteReviewViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
    
}
