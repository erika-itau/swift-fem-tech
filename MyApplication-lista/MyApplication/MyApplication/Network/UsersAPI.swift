//
//  UsersAPI.swift
//  MyApplication
//
//  Created by Erika Albizzati on 18/07/20.
//  Copyright © 2020 Erika Albizzati. All rights reserved.
//

import Foundation

//AppError representa possíveis erros no parse do objeto
enum AppError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}

//Result enum que indica se foi sucesso ou Erro
enum Result<T> {
    case success(T)
    case failure(AppError)
}


struct UsersAPI {
    
    //dataRequest envia a requisicao para a url de parametro e converte para um tipo (que será definido por qm usar esse método) Decodable
    func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
        
        //cria um objecto URL a partir da string enviada por parametro
        guard let dataURL = URL(string: url) else {
            return
        }
        
        //Cria uma URLSession
        let session = URLSession.shared
        
        //Cria uma URLRequest usando a dataURL
        let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        //cria uma dataTask usando session para enviar dados ao servidor
        //completion significa que o código soh entrará no response quando o servidor retornar o resultado da request.
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            
            guard error == nil else {
                //se o objeto tem um erro
                completion(Result.failure(AppError.networkError(error!)))
                return
            }
            
            guard let data = data else {
                //se nao recebeu nenhum dado no retorn da API
                completion(Result.failure(AppError.dataNotFound))
                return
            }
            
            do {
                //tenta criar um Decodable (tipo generico aqui porque qm define o tipo é qm chama esse metodo)
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completion(Result.success(decodedObject))
            } catch let error {
                //se nao for possivel criar o objeto do tipo esperado, error de parse
                completion(Result.failure(AppError.jsonParsingError(error as! DecodingError)))
            }
        })
        
        task.resume()
    }
    
}
