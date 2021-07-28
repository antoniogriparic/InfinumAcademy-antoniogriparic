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
    
    // MARK: - Lifecycle methods -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        fetchShows()
        
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
        
}


extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showsResponse.shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TVShowTableViewCell.self), for: indexPath) as! TVShowTableViewCell
        cell.configure(with: showsResponse.shows[indexPath.row].title)
        return cell
    }
    
}


extension HomeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
