//
//  MoviesViewController.swift
//  Trevin-Test-Project
//
//  Created by Trevin Wisaksana on 04/12/18.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public var dataSource: MoviePosterDataSource = MoviePosterDataSource()
    
    // MARK: - Internal Properties
    
    lazy var moviesCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = self
        return searchBar
    }()
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        hideKeyboardWhenTappedAround()
        
        moviesCollectionView.register(cell: MovieCell.self)
        
        view.addSubview(moviesCollectionView)
        moviesCollectionView.fillInSuperview()
        
        dataSource.delegate = self
        dataSource.fetchMovies(withTitle: "Interstellar")
        
        navigationItem.titleView = searchBar
        
        view.backgroundColor = .white
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        moviesCollectionView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func dismissKeyboard() {
        searchBar.endEditing(true)
    }
    
    private func reloadData() {
        moviesCollectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDelegate

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: MovieCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.model = dataSource.movie(atIndex: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let title = dataSource.movie(atIndex: indexPath).title
        let movieDetailViewController = MovieDetailViewController(title: title)
        
        present(movieDetailViewController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width * 0.4
        let height = collectionView.frame.height * 0.3
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}

// MARK: - UISearchBarDelegate

extension MoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dataSource.fetchMovies(withTitle: searchBar.text ?? "")
        dismissKeyboard()
    }
}

// MARK: - MovieDataSourceDelegate

extension MoviesViewController: MovieDataSourceDelegate {
    func didLoadMovieData() {
        reloadData()
    }
}
