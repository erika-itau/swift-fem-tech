//
//  User.swift
//  MyApplication
//
//  Created by Erika Albizzati on 18/07/20.
//  Copyright © 2020 Erika Albizzati. All rights reserved.
//

struct User: Codable {
    //usando os mesmos nomes presentes na api
    var id: Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
}


//se quisesse nomear os itens de forma diferente, poderia fazer como abaixo:
//
//struct User: Codable {
//
//    var id: Int
//    var nome: String
//    var apelido: String
//    var email: String
//    var telefone: String
//    var site: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case nome = "name"
//        case apelido = "username"
//        case email
//        case telefone = "phone"
//        case site = "website"
//    }
//
//}
