//
//  HomeViewController.swift
//  TV Shows
//
//  Created by Infinum on 22.07.2021..
//

import UIKit
import SVProgressHUD

final class HomeViewController : UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private var showsResponse = ShowsResponse(shows: [])
    private var showService = ShowService()
    private var userService = UserService()
    
    // MARK: - Lifecycle methods -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchShows()
        setUpNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setViewControllers([self], animated: false)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}


private extension HomeViewController {
    
    func fetchShows() {
        
        SVProgressHUD.show()
        
        showService.fetchShows() { [weak self] response in
            
            guard let self = self else {return}
            
            SVProgressHUD.dismiss()
            
            switch response.result {
            case .success(let showsResponse):
                self.showsResponse = showsResponse
                self.tableView.reloadData()
            case .failure(let error):
                print("Error fetching shows! \(error)")
            }
        }
    }
    
    func navigateToShowDetails(show: Show) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let showDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ShowDetailsViewController") as! ShowDetailsViewController
        showDetailsViewController.show = show
        navigationController?.pushViewController(showDetailsViewController, animated: true)
    }
    
    func setUpNavigationBar() {
        let profileItem = UIBarButtonItem(
            image: UIImage(named: "ic-profile"),
            style: .plain,
            target: self,
            action: #selector(profileBarButtonHandler)
        )
        profileItem.tintColor = UIColor(red: 0.32, green: 0.21, blue: 0.55, alpha: 1)
        navigationItem.rightBarButtonItem = profileItem
    }
    
    @objc func profileBarButtonHandler() {
        userService.getCurrentUser() { response in
            switch response.result {
            case .success(let userResponse):
                self.navigateToProfileScreen(user: userResponse.user)
            case .failure( _):
                self.showAlter(title: "something went wrong!")
            }
        }
    }
    
    func navigateToProfileScreen(user: User){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let profileDetailsViewController = storyboard.instantiateViewController(
            withIdentifier: "ProfileDetailsViewController")
            as! ProfileDetailsViewController
        profileDetailsViewController.user = user
        let navigationController = UINavigationController(rootViewController:profileDetailsViewController)
        present(navigationController, animated: true)
    }
    

}


extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showsResponse.shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TVShowTableViewCell.self), for: indexPath) as! TVShowTableViewCell
        cell.configure(with: showsResponse.shows[indexPath.row])
        return cell
    }
    
}


extension HomeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToShowDetails(show: showsResponse.shows[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
}
