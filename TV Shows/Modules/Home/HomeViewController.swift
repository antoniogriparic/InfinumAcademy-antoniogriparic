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
    private var topRatedResponse = ShowsResponse(shows: [])
    private var showService = ShowService()
    private var userService = UserService()
    var notificationToken: NSObjectProtocol?
    var usingTopRated = false
    
    // MARK: - Lifecycle methods -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        
    }
    
    deinit {
        print("deinit HOME VC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.tabBar.isHidden = false
    }
    
}


private extension HomeViewController {
    
    func fetchShows() {
        
        SVProgressHUD.show()
        
        showService.fetchShows() { [weak self] response in
            
            guard let self = self else { return }
            
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
    
    func fetchTopRated() {
        SVProgressHUD.show()
        
        showService.fetchTopRated() { [weak self] response in
            
            guard let self = self else { return }
            
            SVProgressHUD.dismiss()
            
            switch response.result {
            case .success(let showsResponse):
                self.topRatedResponse = showsResponse
            case .failure(let error):
                print("Error fetching top rated! \(error)")
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
            case .failure:
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
        let navigationController = UINavigationController(rootViewController: profileDetailsViewController)
        present(navigationController, animated: true)
    }
    
    func setUpLogOutNotification() {
        notificationToken = NotificationCenter
            .default
            .addObserver(
                forName: NotificationDidLogout,
                object: nil,
                queue: nil,
                using: { _ in
                    let storyboard = UIStoryboard(name: "Login", bundle: nil)
                    let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.navigationController?.navigationController?.setViewControllers([loginViewController], animated: true)
                }
            )
    }
    
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        fetchShows()
        fetchTopRated()
        setUpNavigationBar()
        setUpLogOutNotification()
    }
    
}

// MARK: - Table View Data Source

extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if usingTopRated {
            return topRatedResponse.shows.count
        } else {
            return showsResponse.shows.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TVShowTableViewCell.self), for: indexPath) as! TVShowTableViewCell
        if usingTopRated {
            cell.configure(with: topRatedResponse.shows[indexPath.row])
        } else {
            cell.configure(with: showsResponse.shows[indexPath.row])
        }
        return cell
    }
    
}

// MARK: - Table View Delegate

extension HomeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if usingTopRated {
            navigateToShowDetails(show: topRatedResponse.shows[indexPath.row])
        } else {
            navigateToShowDetails(show: showsResponse.shows[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
}
