//
//  ViewModel.swift
//  Trevin-Test-Project
//
//  Created by Trevin Wisaksana on 04/12/18.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import Foundation

protocol MovieViewModel {
    var title: String { get set }
    var year: String { get set }
    var rated: String { get set }
    var director: String { get set }
}

struct Movie: MovieViewModel {
    var title: String
    var year: String
    var rated: String
    var director: String
    
}
