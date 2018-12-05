//
//  MovieDetailViewController.swift
//  Trevin-Test-Project
//
//  Created by Trevin Wisaksana on 04/12/18.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import UIKit
import Kingfisher

final class MovieDetailViewController: UIViewController {
    
    // MARK: - Internal Properties
    
    lazy var movieDetailView: MovieDetailView = {
        let view = MovieDetailView(frame: .zero)
        return view
    }()
    
    // MARK: - Public Properties
    
    public var dataSource = MovieDetailDataSource()
    
    // MARK: - Setup
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        
        dataSource.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        view.addSubview(movieDetailView)
        movieDetailView.fillInSuperview()
        
        dataSource.fetchMovie { (movie) in
            if let movie = movie {
                DispatchQueue.main.async {
                    self.movieDetailView.model = movie
                }
            }
        }
        
        movieDetailView.closeButton.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
