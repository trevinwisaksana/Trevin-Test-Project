//
//  MovieCell.swift
//  Trevin-Test-Project
//
//  Created by Trevin Wisaksana on 04/12/18.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    
    // MARK: - Internal Properties
    
    private lazy var titleBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255, a: 0.3)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Interstellar"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
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
        addSubview(titleLabel)
        addSubview(titleBackgroundView)
        addSubview(posterImageView)
        
        posterImageView.fillInSuperview()
        
        backgroundColor = .blue
        
        NSLayoutConstraint.activate([
            titleBackgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            titleBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            titleBackgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            titleBackgroundView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10)
        ])
    }
    
    // MARK: - Dependency injection
    
    /// The model contains data used to populate the view.
    public var model: MovieViewModel? {
        didSet {
            if let model = model {
                titleLabel.text = model.title
            }
        }
    }
    
}
