//
//  UsersViewController.swift
//  MyApplication
//
//  Created by Erika Albizzati on 18/07/20.
//  Copyright © 2020 Erika Albizzati. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    var users: [User] = []
    let cellReuseIdentifier = "cell"
    var usersApi = UsersAPI()

    // Essa função é uma das funções presentes no chamado `Life cycle` de uma ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
        setupTableView()
    }
    
    func setupTableView() {
        //Essa propriedade diz que não é possível interagir com a tabela (clicar/selecionar) nenhum item. Essa propriedade tem valor default true
        tableView.allowsSelection = true
        
        //aqui estou dizendo que essa mesma classe implementará os metodos de delegate da tabela.
        tableView.delegate = self
        
        //aqui estou dizendo que essa mesma classe implementará os metodos de datasource da tabela.
        tableView.dataSource = self
        
        //esse é um `hack` pra evitar que aparece mais linhas (separadores) ao final da tabela
        tableView.tableFooterView = UIView()
    }
    
    func loadUsers() {
        
        // [User].self indica o tipo para o qual o dataRequest irá tentar parsear o que receber da api.
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

    //esse método é chamado automaticamente sempre que há uma chamada por performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailViewController {
            let row = (sender as? NSIndexPath)?.row ?? 1
            viewController.userId = row
        }
    }
    
}

extension UsersViewController: UITableViewDelegate {
    
    //Determina o valor da altura de cada célula da tabela. Espera um valor numérico como retorno, mas no caso usei o valor `UITableView.automaticDimension` pois ele diz que é para a propria tabela calcular a altura (baseada no autolayout)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //Esse método é chamado automaticamente quando clicar numa celula, com a propriedade `allowsSelection` habilitada.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetailSegue", sender: indexPath)
        
        //precisamos dizer para a celula, que acabou de ser selecionada, voltar para o estado desselecionado, senao a próxima interaçao com a tabela, irá desselecionar a ultima célula clicada.
        tableView.deselectRow(at: indexPath, animated: false)
    }

}

extension UsersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    //esse é o método que vai "montar a tabela" visualmente, qual tipo de celular usar, cores, fontes, etc. Usualmente essa lógica é separada em uma outra classe, para clareza de código. No exemplo, usamos UITableViewCell, que é um tipo padrão de celula que iOS nos fornece, mas poderíamos ter usado outro tipo de cell, e para isso deveriamos implementar seu layout em outra classe
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
