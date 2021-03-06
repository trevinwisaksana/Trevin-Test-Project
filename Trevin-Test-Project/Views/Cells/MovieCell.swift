//
//  MovieCell.swift
//  Trevin-Test-Project
//
//  Created by Trevin Wisaksana on 04/12/18.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import UIKit
import Kingfisher

final class MovieCell: UICollectionViewCell {
    
    // MARK: - Internal Properties
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addSubview(posterImageView)
        posterImageView.fillInSuperview()
    }
    
    // MARK: - Dependency injection
    
    /// The model contains data used to populate the view.
    public var model: MoviePosterViewModel? {
        didSet {
            if let model = model {
                do {
                    let posterURL = try model.posterURL.asURL()
                    posterImageView.kf.setImage(with: posterURL)
                    posterImageView.kf.indicatorType = .activity
                } catch {
                    fatalError("Failed to convert string to URL")
                }
            }
        }
    }
    
}
