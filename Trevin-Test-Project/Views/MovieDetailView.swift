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
    
    public var model: MovieDetailViewModel? {
        didSet {
            if let model = model {
                titleLabel.text = model.title
                yearLabel.text = model.year
                plotLabel.text = model.plot
                
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var posterScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
        return scrollView
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
        label.numberOfLines = 0
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
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Private Properties
    
    private var captionViewHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(closeButton)
        
        addSubview(posterScrollView)
        posterScrollView.fillInSuperview()
        posterScrollView.addSubview(posterImageView)
        sendSubviewToBack(posterScrollView)
        
        addSubview(captionView)
        captionView.addSubview(titleLabel)
        captionView.addSubview(yearLabel)
        captionView.addSubview(plotLabel)
        captionView.addSubview(dragIndicator)
        
        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUpOnDragIndicator(_:)))
        swipeUpGestureRecognizer.direction = .up
        captionView.addGestureRecognizer(swipeUpGestureRecognizer)
        
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDownOnDragIndicator(_:)))
        swipeDownGestureRecognizer.direction = .down
        captionView.addGestureRecognizer(swipeDownGestureRecognizer)
        
        captionViewHeightConstraint = captionView.heightAnchor.constraint(equalToConstant: 100)
        captionViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            closeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            
            captionView.leftAnchor.constraint(equalTo: leftAnchor),
            captionView.rightAnchor.constraint(equalTo: rightAnchor),
            captionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            
            posterImageView.leftAnchor.constraint(equalTo: posterScrollView.leftAnchor),
            posterImageView.rightAnchor.constraint(equalTo: posterScrollView.rightAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: posterScrollView.bottomAnchor),
            posterImageView.topAnchor.constraint(equalTo: posterScrollView.topAnchor),
            posterImageView.centerXAnchor.constraint(equalTo: posterScrollView.centerXAnchor),
            posterImageView.centerYAnchor.constraint(equalTo: posterScrollView.centerYAnchor),
            
            dragIndicator.centerXAnchor.constraint(equalTo: captionView.centerXAnchor),
            dragIndicator.topAnchor.constraint(equalTo: captionView.topAnchor, constant: 6),
            dragIndicator.heightAnchor.constraint(equalToConstant: 6),
            dragIndicator.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leftAnchor.constraint(equalTo: captionView.leftAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: captionView.rightAnchor, constant: -15),
            titleLabel.topAnchor.constraint(equalTo: captionView.topAnchor, constant: 20),
            
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            yearLabel.leftAnchor.constraint(equalTo: captionView.leftAnchor, constant: 15),
            
            plotLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 10),
            plotLabel.leftAnchor.constraint(equalTo: captionView.leftAnchor, constant: 15),
            plotLabel.rightAnchor.constraint(equalTo: captionView.rightAnchor, constant: -15)
        ])
    }
    
    @objc
    private func didSwipeUpOnDragIndicator(_ sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.2) {
            self.captionViewHeightConstraint?.constant = 500
            self.layoutIfNeeded()
        }
    }
    
    @objc
    private func didSwipeDownOnDragIndicator(_ sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.1) {
            self.captionViewHeightConstraint?.constant = 100
            self.layoutIfNeeded()
        }
    }
    
}

// MARK: - UIScrollViewDelegate

extension MovieDetailView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return posterImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    }
}
