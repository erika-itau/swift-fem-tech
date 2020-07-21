//
//  UsersViewController.swift
//  MyApplication
//
//  Created by Erika Albizzati on 18/07/20.
//  Copyright © 2020 Erika Albizzati. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
        
    var usersApi = UsersAPI()
    
    // Essa função é uma das funções presentes no chamado `Life cycle` de uma ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
    }
    
    func loadUsers() {
        // [User].self indica o tipo para o qual o dataRequest irá tentar parsear o que receber da api.
        usersApi.dataRequest(with: Endpoints.users, objectType: [User].self) { (result) in

            switch result {
            case .success(let users):
                print("\n******* foi possível pegar os usuários e parsea-los*******\n")
                print(users)
                
            case .failure(let error):
                print("\n******* HOUVE UM ERRO *******\n")
                print(error)
            }
        }
    }

}
