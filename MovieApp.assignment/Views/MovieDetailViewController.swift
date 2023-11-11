//
//  MovieDetailViewController.swift
//  MovieApp.assignment
//
//  Created by Salome Lapiashvili on 11.11.23.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    //MARK: properties
    var movie: Movie?
    let titleLabel = UILabel()
    let releaseDateLabel = UILabel()
    let ratingLabel = UILabel()
    let overviewTextView = UITextView()
    let posterImageView = UIImageView()
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        setupUI()
        updateUIWithMovieDetails()
    }
    
    //MARK: Private methods
    private func setupUI() {
        setupPosterImageView()
        setupTitleLabel()
        setupReleaseDateLabel()
        setupRatingLabel()
        setupOverviewTextView()
        setupConstraints()
    }
    
    private func setupPosterImageView() {
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.layer.cornerRadius = 10
        posterImageView.layer.masksToBounds = true
        view.addSubview(posterImageView)
    }

    private func setupTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
    }

    private func setupReleaseDateLabel() {
        releaseDateLabel.font = .systemFont(ofSize: 18, weight: .regular)
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(releaseDateLabel)
    }

    private func setupRatingLabel() {
        ratingLabel.font = .systemFont(ofSize: 18, weight: .regular)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ratingLabel)
    }

    private func setupOverviewTextView() {
        overviewTextView.isEditable = false
        overviewTextView.font = .systemFont(ofSize: 16)
        overviewTextView.textColor = .white
        overviewTextView.backgroundColor = .darkGray
        overviewTextView.layer.cornerRadius = 10
        overviewTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overviewTextView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            ratingLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            overviewTextView.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 16),
            overviewTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            overviewTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            overviewTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func updateUIWithMovieDetails() {
        guard let movie = movie else { return }

        if let posterURL = movie.posterURL {
            posterImageView.kf.setImage(
                with: posterURL,
                placeholder: UIImage(named: "placeholder"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        } else {
            posterImageView.image = UIImage(named: "placeholder")
        }

        titleLabel.text = movie.title
        releaseDateLabel.text = "Release Date: \(movie.releaseDate)"
        ratingLabel.text = "Rating: \(movie.rating)"
        overviewTextView.text = movie.overview
    }
}


