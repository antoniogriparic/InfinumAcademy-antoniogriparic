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
    private let showService = ShowService()
    private var reviewResponse = ReviewResponse(reviews: [])
    private let refreshControl = UIRefreshControl()
    
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
    
}

private extension ShowDetailsViewController {

    private func fetchReviews() {
        guard let show = show else { return } 
        showService.fetchReviewsList(showId: show.id) { [weak self] response in
               
            guard let self = self else { return }
        
            switch response.result {
            case .success(let reviewResponse):
                self.reviewResponse = reviewResponse
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            case .failure(let error):
                print("Error fetching reviews! \(error)")
            }
        }
    }
   
    private func setUpUI() {
        self.title = show?.title
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        fetchReviews()
        newReviewButton.layer.cornerRadius = 21.5
        refreshControl.addTarget(self, action: #selector(refreshReviews(_:)), for: .valueChanged)
        tabBarController?.tabBar.isHidden = true
    }
   
    @objc private func refreshReviews(_ sender: Any) {
        fetchReviews()
    }

}

// MARK: - Table View Data Source

extension ShowDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewResponse.reviews.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: ShowDetailsTableViewCell.self),
                for: indexPath) as! ShowDetailsTableViewCell
            cell.configure(show: show)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing : ReviewTableViewCell.self),
                for: indexPath) as! ReviewTableViewCell
            cell.configure(review: reviewResponse.reviews[indexPath.row - 1])
            return cell
        }
    }
    
}

// MARK: - Table View Delegate

extension ShowDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: - Write Review ViewController Delegate

extension ShowDetailsViewController: WriteReviewViewControllerDelegate {
    
    func reviewDidPublish() {
        fetchReviews()
    }
    
}
