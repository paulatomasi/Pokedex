//
//  RequestMaker.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

class RequestMaker {
    
    static let decoder = JSONDecoder()
    let baseURl = "http://localhost:3000/"
    let session = URLSession.shared
    
    typealias RequestResult<T> = Result<T, RequestMakerError>
    typealias CompletionCallBack<T: Decodable> = (RequestResult<T>) -> Void
    typealias SuccessCallback<T: Decodable> = (T) -> Void
    
    func make<T: Decodable>(withEndpoint endpoint: Endpoint, completion: @escaping SuccessCallback<T>) {
        make(withEndpoint: endpoint) { (result: RequestResult<T>) in
            switch result {
            case .success(let object):
                completion(object)
            case .failure:
                break
            }
        }
    }
    
    func make<T: Decodable>(withEndpoint endpoint: Endpoint, completion: @escaping CompletionCallBack<T>) {
        
        guard let url = URL(string: "\(baseURl)\(endpoint.url)") else {
            completion(.failure(.malformedURL))
            return
        }
        
        let dataTask = session.dataTask(with: url) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            guard error == nil else {
                completion(.failure(.requestInvalid))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedObject = try RequestMaker.decoder.decode(T.self, from: data)
                
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        
        dataTask.resume()
    }
}

enum Endpoint {
    case list
    case details(query: String)
    case moves
    
    var url: String {
        switch self {
        case .list:
            return "list"
        case let .details(query):
            return "details/\(query)"
        case .moves:
            return "moves"
        }
    }
}

enum RequestMakerError: Error {
    case malformedURL
    case requestInvalid
    case invalidData
    case decodingFailed
}
