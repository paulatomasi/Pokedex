//
//  FavoriteListInteractor.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 19/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

class FavoriteListInteractor {
    
    private let requestMaker = RequestMaker()
    
    weak var output: FavoriteListInteractorOutput?
    
    init(output: FavoriteListInteractorOutput) {
        self.output = output
    }
}

extension FavoriteListInteractor: FavoriteListInteractorInput {
    func fetchData() {
        self.requestMaker.make(withEndpoint: .favorites(ids: ["1", "7"])) { (data: [Pokemon]) in
            self.output?.dataFetched(data)
        }
    }
}
