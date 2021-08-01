//
//  ShowDetailsViewController.swift
//  TV Shows
//
//  Created by Infinum on 28.07.2021..
//

import UIKit

class ShowDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var newReviewButton: UIButton!
    
    // MARK: - Properties
   
    var show: Show? = nil
    private var showService = ShowService()
    private var reviewResponse = ReviewResponse(reviews: [])
    
    // MARK: - Lifecycle methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    // MARK: - Actions

    @IBAction func newReviewButtonHandler() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let writeReviewViewController = storyboard.instantiateViewController(withIdentifier: "WriteReviewViewController") as! WriteReviewViewController
        writeReviewViewController.show = show
        writeReviewViewController.delegate = self
        let navigationController = UINavigationController(rootViewController:writeReviewViewController)
        present(navigationController, animated: true)
    }
    
    // MARK: - Private Functions
    
     private func fetchReviews() {
        guard let unwrapedShow = show else {return}
        showService.fetchReviewsList(showId: unwrapedShow.id) { [weak self] response in
                
                guard let self = self else {return}
                
                switch response.result {
                case .success(let reviewResponse):
                    self.reviewResponse = reviewResponse
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error fetching reviews! \(error)")
                }
        }
    }
    
    private func setUpUI() {
        self.title = show?.title
        tableView.dataSource = self
        fetchReviews()
        newReviewButton.layer.cornerRadius = 21.5
    }

}


extension ShowDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewResponse.reviews.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: ShowDetailsTableViewCell.self),
                for: indexPath) as! ShowDetailsTableViewCell
            cell.configure(description: show?.description ?? "nesto",
                           numberOfReviews: show?.noOfReviews ?? 0,
                           averageRating: show?.averageRating ?? 0)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing : ReviewTableViewCell.self),
                for: indexPath) as! ReviewTableViewCell
            cell.configure(email: reviewResponse.reviews[indexPath.row - 1].user.email,
                           comment: reviewResponse.reviews[indexPath.row - 1].comment,
                           rating: reviewResponse.reviews[indexPath.row - 1].rating)
            return cell
        }
    }
    
    
}


extension ShowDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 650
        }
        else {
            return 140
        }
    }
    
}

extension ShowDetailsViewController: WriteReviewViewControllerDelegate {
    
    func reviewDidPublish() {
        self.fetchReviews()
    }
    
}
