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
        //Essa propriedade diz que não é possível interagir com a tabela (clicar/selecionar) nenhum item. Essa propriedade tem valor default true
        tableView.allowsSelection = false
        
        //aqui estou dizendo que essa mesma classe implementará os metodos de delegate da tabela.
        tableView.delegate = self
        
        //aqui estou dizendo que essa mesma classe implementará os metodos de datasource da tabela.
        tableView.dataSource = self
        
        //esse é um `hack` pra evitar que aparece mais linhas (separadores) ao final da tabela
        tableView.tableFooterView = UIView()
    }

    func loadUsersPosts() {
        let url = Endpoints.posts + "?\(userId)"
        
        // [Post].self indica o tipo para o qual o dataRequest irá tentar parsear o que receber da api.
        usersApi.dataRequest(with: url, objectType: [Post].self) { (result) in
            switch result {
            case .success(let posts):
                self.posts = posts
            case .failure(let error):
                print("\n******* HOUVE UM ERRO *******\n")
                self.posts = []
                print(error)
            }
            //o método `reloadData()` atualiza os valores da tabela, ele deve estar dentro do `DispatchQueue` `asyn` para evitar que trave a tela (e impeça o usuário de interagir) enquanto ele faz essa atualizaçao.
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

}

extension DetailViewController: UITableViewDelegate {
    
    //Determina o valor da altura de cada célula da tabela. Espera um valor numérico como retorno, mas no caso usei o valor `UITableView.automaticDimension` pois ele diz que é para a propria tabela calcular a altura (baseada no autolayout)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension DetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    //esse é o método que vai "montar a tabela" visualmente, qual tipo de celular usar, cores, fontes, etc. Usualmente essa lógica é separada em uma outra classe, para clareza de código. No exemplo, usamos UITableViewCell, que é um tipo padrão de celula que iOS nos fornece, mas poderíamos ter usado outro tipo de cell, e para isso deveriamos implementar seu layout em outra classe
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        
        cell.selectionStyle = .none
        cell.textLabel?.text = "título: " + posts[indexPath.row].title
        //é possível alterar cores e fontes aqui, acessando a proriedade textLabel ou detailTextLabel
        cell.textLabel?.textColor = .purple
        cell.detailTextLabel?.text = "conteúdo: " + posts[indexPath.row].body
        cell.detailTextLabel?.numberOfLines = 0
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
}
