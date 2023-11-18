//
//  MovieDetailViewController.swift
//  MovieApp.assignment
//
//  Created by Salome Lapiashvili on 11.11.23.
//
import UIKit

final class MovieDetailViewController: UIViewController {
    // MARK: Properties
    var viewModel: MovieDetailViewModel?
    
    private let titleLabel = UILabel()
    private let releaseYearLabel = UILabel()
    private let ratingLabel = UILabel()
    private let overviewTextView = UITextView()
    private let posterImageView = UIImageView()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        setupUI()
        updateUIWithMovieDetails()
    }
    
    // MARK: Private methods
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
        posterImageView.layer.cornerRadius = 20
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
        releaseYearLabel.font = .systemFont(ofSize: 18, weight: .regular)
        releaseYearLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(releaseYearLabel)
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
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseYearLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewTextView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 40
        
        NSLayoutConstraint.activate([
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            posterImageView.widthAnchor.constraint(equalToConstant: 240),
            posterImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: posterImageView.topAnchor, constant: -padding),
            titleLabel.widthAnchor.constraint(equalTo: posterImageView.widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            releaseYearLabel.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor),
            releaseYearLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: padding * 2),
            releaseYearLabel.widthAnchor.constraint(equalTo: posterImageView.widthAnchor),
            releaseYearLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.centerXAnchor.constraint(equalTo: releaseYearLabel.centerXAnchor),
            ratingLabel.topAnchor.constraint(equalTo: releaseYearLabel.bottomAnchor, constant: padding),
            ratingLabel.widthAnchor.constraint(equalTo: releaseYearLabel.widthAnchor),
            ratingLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            overviewTextView.centerXAnchor.constraint(equalTo: ratingLabel.centerXAnchor),
            overviewTextView.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: padding),
            overviewTextView.widthAnchor.constraint(equalTo: ratingLabel.widthAnchor),
            overviewTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
    
    
    private func updateUIWithMovieDetails() {
        guard let viewModel = viewModel else { return }
        
        loadImage(with: viewModel.posterURL)
        
        titleLabel.text = viewModel.title
        releaseYearLabel.text = viewModel.releaseDate
        ratingLabel.text = viewModel.rating
        overviewTextView.text = viewModel.overview
    }
    
    private func loadImage(with url: URL?) {
        guard let url = url else {
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(named: "placeholder")
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error)")
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(named: "placeholder")
                }
                return
            }
            
            guard let data = data else {
                print("No data received when loading image.")
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(named: "placeholder")
                }
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.posterImageView.image = image
                }
            } else {
                print("Failed to create image from data.")
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(named: "placeholder")
                }
            }
        }.resume()
    }
}


