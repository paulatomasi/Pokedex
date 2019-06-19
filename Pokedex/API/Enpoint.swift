//
//  Enpoint.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 19/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

extension RequestMaker {
    enum Endpoint {
        case list
        case details(query: String)
        case moves
        case favorites(ids: Set<String>)
        
        var url: String {
            switch self {
            case .list:
                return "list"
            case let .details(query):
                return "details/\(query)"
            case .moves:
                return "moves"
            case let .favorites(ids):
                return "details\(destrinchIdAsParams(ids))"
            }
        }
    }
}


private func destrinchIdAsParams(_ ids: Set<String>) -> String {
    var localCopiedIds = ids
    var result = "?id=\(localCopiedIds.removeFirst())"
    
    for id in localCopiedIds {
        result += "&id=\(id)"
    }
    
    
    return result
}
