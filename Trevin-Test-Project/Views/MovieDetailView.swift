//
//  MovieDetailView.swift
//  Trevin-Test-Project
//
//  Created by Trevin Wisaksana on 05/12/18.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class MovieDetailView: UIView {
    
    // MARK: - View Model
    
    public var model: MovieViewModel?
    
    // MARK: - Internal Properties
    
    lazy var closeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        return button
    }()
    
    lazy var dragIndicator: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.backgroundColor = .white
        return view
    }()
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var captionView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(r: 35, g: 35, b: 35, a: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Light", size: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var plotLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Setup
    
    init(model: MovieViewModel?, frame: CGRect) {
        super.init(frame: frame)
        
        if let model = model {
            self.model = model
        }
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(closeButton)
        
        addSubview(posterImageView)
        posterImageView.fillInSuperview()
        
        addSubview(captionView)
        captionView.addSubview(titleLabel)
        captionView.addSubview(yearLabel)
        captionView.addSubview(plotLabel)
        captionView.addSubview(dragIndicator)
        
        NSLayoutConstraint.activate([
            closeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            
            captionView.leftAnchor.constraint(equalTo: leftAnchor),
            captionView.rightAnchor.constraint(equalTo: rightAnchor),
            captionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            captionView.heightAnchor.constraint(equalToConstant: 100),
            
            dragIndicator.centerXAnchor.constraint(equalTo: captionView.centerXAnchor),
            dragIndicator.topAnchor.constraint(equalTo: captionView.topAnchor, constant: 6),
            dragIndicator.heightAnchor.constraint(equalToConstant: 6),
            dragIndicator.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leftAnchor.constraint(equalTo: captionView.leftAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: captionView.topAnchor, constant: 15),
            
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            yearLabel.leftAnchor.constraint(equalTo: captionView.leftAnchor, constant: 15)
        ])
        
        if let model = model {
            titleLabel.text = model.title
            yearLabel.text = model.year
            
            do {
                let posterURL = try model.posterURL.asURL()
                posterImageView.kf.setImage(with: posterURL)
            } catch {
                // TODO: Handle error
            }
        }
    }
    
}
