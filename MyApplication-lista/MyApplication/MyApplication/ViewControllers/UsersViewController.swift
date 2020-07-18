//
//  UsersViewController.swift
//  MyApplication
//
//  Created by Erika Albizzati on 18/07/20.
//  Copyright © 2020 Erika Albizzati. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
        
    let cellReuseIdentifier = "cell"
    var usersApi = UsersAPI()
    @IBOutlet weak var tableView: UITableView!
    var users: [User] = []
    
    // Essa função é uma das funções presentes no chamado `Life cycle` de uma ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    
    func loadUsers() {
        usersApi.dataRequest(with: Endpoints.users, objectType: [User].self) { (result) in
            switch result {
            case .success(let users):
                print("\n******* foi possível pegar os usuários e parsea-los*******\n")
                print(users)
                self.users = users
            case .failure(let error):
                print("\n******* HOUVE UM ERRO *******\n")
                self.users = []
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
}

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetailSegue", sender: nil)
    }

}

extension UsersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        
        cell.selectionStyle = .none
        cell.textLabel?.text = "e-mail: " + users[indexPath.row].email
        cell.detailTextLabel?.text = "nome: " + users[indexPath.row].name + "\napelido: " + users[indexPath.row].username
        cell.detailTextLabel?.numberOfLines = 0
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
}
