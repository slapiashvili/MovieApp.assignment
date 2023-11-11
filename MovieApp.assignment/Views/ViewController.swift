//
//  MoviesTableViewController.swift
//  MovieApp.assignment
//
//  Created by Salome Lapiashvili on 11.11.23.
//

import UIKit

final class MoviesTableViewController: UITableViewController {
    // MARK: Properties
    
    private let searchBar = UISearchBar()
    private var movies = [Movie]()
    private var originalMovies = [Movie]()
    
    private var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No movies available."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.isHidden = true
        return label
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        configureSearchBar()
        configureTableView()
        loadOriginalData()
    }
    
    // MARK: Configuration
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search Movies"
        navigationItem.titleView = searchBar
    }
    
    private func configureTableView() {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        view.addSubview(emptyStateLabel)
        emptyStateLabel.frame = view.bounds
    }
    
    // MARK:  Data Loading
    
    private func loadOriginalData() {
        NetworkManager.shared.fetchMovies(from: "movie/popular") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.originalMovies = movies
                    self?.movies = movies
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.presentAlert(with: error.localizedDescription)
                }
                self?.updateUIForEmptyState()
            }
        }
    }
    
    // MARK:  UITableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let cellHeight = screenHeight / 4.0
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.darkGray
        } else {
            cell.contentView.backgroundColor = UIColor.gray
        }
        
        cell.configure(with: movie, isEvenRow: indexPath.row % 2 == 0)
        cell.selectionStyle = .default
        return cell
    }
    
    // MARK: UITableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        let detailVC = MovieDetailViewController()
        
        Task {
            do {
                let movieDetails = try await NetworkManager.shared.fetchMovieDetails(for: movie.id)
                detailVC.movie = movieDetails
                self.navigationController?.pushViewController(detailVC, animated: true)
            } catch {
                self.presentAlert(with: "Failed to load movie details.")
            }
        }
    }
}


extension MoviesTableViewController: UISearchBarDelegate {
    // MARK: UISearchBarDelegate Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            movies = originalMovies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        loadOriginalData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            movies = originalMovies
            tableView.reloadData()
        } else {
            movies = originalMovies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            tableView.reloadData()
        }
    }
}

extension MoviesTableViewController {
    // MARK: Helper Methods
    
    private func presentAlert(with message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func updateUIForEmptyState() {
        if movies.isEmpty {
            emptyStateLabel.isHidden = false
            tableView.separatorStyle = .none
        } else {
            emptyStateLabel.isHidden = true
            tableView.separatorStyle = .singleLine
        }
    }
}
