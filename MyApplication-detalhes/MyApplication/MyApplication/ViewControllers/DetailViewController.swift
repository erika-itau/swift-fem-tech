//
//  DetailViewController.swift
//  MyApplication
//
//  Created by Erika Albizzati on 18/07/20.
//  Copyright © 2020 Erika Albizzati. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
        
    let cellReuseIdentifier = "cell"
    var userId: Int = 0
    var posts: [Post] = []
    var usersApi = UsersAPI()
    @IBOutlet weak var tableView: UITableView!
    
    // Essa função é uma das funções presentes no chamado `Life cycle` de uma ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

        loadUsersPosts()
    }
    
    func setupTableView() {
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }


    
    func loadUsersPosts() {
        let url = Endpoints.posts + "?\(userId)"
        usersApi.dataRequest(with: url, objectType: [Post].self) { (result) in
            switch result {
            case .success(let posts):
                self.posts = posts
            case .failure(let error):
                print("\n******* HOUVE UM ERRO *******\n")
                self.posts = []
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension DetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        
        cell.selectionStyle = .none
        cell.textLabel?.text = "título: " + posts[indexPath.row].title
        cell.detailTextLabel?.text = "conteúdo: " + posts[indexPath.row].body
        cell.detailTextLabel?.numberOfLines = 0
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
}
