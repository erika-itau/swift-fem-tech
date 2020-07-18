//
//  HomeViewController.swift
//  MyApplication
//
//  Created by Erika Albizzati on 18/07/20.
//  Copyright © 2020 Erika Albizzati. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var entryButton: UIButton!
    
    
    // Essa função é uma das funções presentes no chamado `Life cycle` de uma ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtonAppearance()
    }
    
    //Aqui é uma forma de alterar visualmente o botão, que também pode ser feito pela storyboard ;)
    func setupButtonAppearance() {
        entryButton.layer.cornerRadius = 10
        entryButton.clipsToBounds = true
    }

}
