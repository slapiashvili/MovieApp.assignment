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
    private var moviesViewModel = MoviesViewModel()
    
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
    
    // MARK: Data Loading
    private func loadOriginalData() {
        Task {
            do {
                let movies = try await moviesViewModel.fetchMovies()
                DispatchQueue.main.async { [weak self] in
                    self?.moviesViewModel.originalMovies = movies
                    self?.moviesViewModel.movies = movies
                    self?.tableView.reloadData()
                    self?.updateUIForEmptyState()
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.presentAlert(with: "Failed to load movies.")
                }
            }
        }
    }
    
    // MARK: UITableViewDataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesViewModel.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        let movie = moviesViewModel.movies[indexPath.row]
        
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
        let movie = moviesViewModel.movies[indexPath.row]
        
        Task {
            do {
                let movieDetails = try await moviesViewModel.fetchMovieDetails(for: movie.id)
                
                DispatchQueue.main.async { [weak self] in
                    let detailVC = MovieDetailViewController()
                    detailVC.viewModel = MovieDetailViewModel(movie: movieDetails)
                    self?.navigationController?.pushViewController(detailVC, animated: true)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.presentAlert(with: "Failed to load movie details.")
                }
            }
        }
    }
}
// MARK: - UISearchBarDelegate Methods

extension MoviesTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            moviesViewModel.movies = moviesViewModel.originalMovies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            tableView.reloadData()
            updateUIForEmptyState()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        loadOriginalData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            moviesViewModel.movies = moviesViewModel.originalMovies
            tableView.reloadData()
            updateUIForEmptyState()
        } else {
            moviesViewModel.movies = moviesViewModel.originalMovies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            tableView.reloadData()
            updateUIForEmptyState()
        }
    }
}

// MARK: - Helper Methods
extension MoviesTableViewController {
    private func updateUIForEmptyState() {
        emptyStateLabel.isHidden = !moviesViewModel.movies.isEmpty
    }
    
    private func presentAlert(with message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

