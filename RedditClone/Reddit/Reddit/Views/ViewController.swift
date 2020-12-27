//
//  ViewController.swift
//  RedditClone
//
//  Created by William Huynh on 12/21/20.
//

import UIKit
import SafariServices

class ViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: RedditCoordinator?
    var viewModel: RedditViewModel!
    
    let myRefreshControl = UIRefreshControl()
    var searchText = "all"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Reddit"
        
        loadReddits()
        
        myRefreshControl.addTarget(self, action: #selector(loadReddits), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    func showRedditWebPage(index: Int) {
        if let url = URL(string: viewModel.getSubRedditLink(atRow: index)) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
    
    @objc func loadReddits() {
        viewModel.loadReddits(subRedditTitle: self.searchText) { (success) in
            DispatchQueue.main.async {
                if success {
                    self.tableView.reloadData()
                    self.myRefreshControl.endRefreshing()
                } else {
                    let alert = UIAlertController(title: "Ooops something went wrong", message: "The reddits couldn't load, try searching for a different topic or all", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        }
    }
}

//MARK: - UITableViewDataSource functions
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        if searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
            return
        }
        
        showRedditWebPage(index: indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfReddits()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.getRedditTitle(atRow: indexPath.row)
        content.secondaryText = viewModel.getSubRedditTitle(atRow: indexPath.row)
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}

//MARK: - UISearchBarDelegate functions
extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        guard var searchText = searchBar.text else { return }
        print(searchText)
        if searchText == "" {
            searchText = "all"
        }
        self.searchText = searchText
        loadReddits()
    }
}
