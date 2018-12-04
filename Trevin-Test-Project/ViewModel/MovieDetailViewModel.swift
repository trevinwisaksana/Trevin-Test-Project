//
//  MovieDetailViewModel.swift
//  Trevin-Test-Project
//
//  Created by Trevin Wisaksana on 05/12/18.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import Foundation

protocol MovieDetailViewModel {
    var title: String { get set }
    var year: String { get set }
    var rated: String { get set }
    var director: String { get set }
}

struct MovieDetail: MovieViewModel {
    var title: String
    var year: String
    var rated: String
    var director: String
}
