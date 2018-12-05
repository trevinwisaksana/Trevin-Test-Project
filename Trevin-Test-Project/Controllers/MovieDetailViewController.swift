//
//  MovieDetailViewController.swift
//  Trevin-Test-Project
//
//  Created by Trevin Wisaksana on 04/12/18.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    // MARK: - Internal Properties
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Public Properties
    
    public var movie: MovieViewModel? {
        didSet {
            
        }
    }
    
    // MARK: - Setup
    
    init(movie: MovieViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.movie = movie
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
    }
    
}
