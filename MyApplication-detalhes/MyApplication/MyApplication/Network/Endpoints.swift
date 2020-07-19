//
//  Endpoints.swift
//  MyApplication
//
//  Created by Erika Albizzati on 18/07/20.
//  Copyright © 2020 Erika Albizzati. All rights reserved.
//

import Foundation

struct Endpoints {
    static let users = "\(API.baseUrl)/users"
    static let posts = "\(API.baseUrl)/posts/"
}

struct API {
    static let baseUrl = "https://jsonplaceholder.typicode.com"
}
