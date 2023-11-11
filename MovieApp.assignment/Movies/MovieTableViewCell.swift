import UIKit
import Kingfisher



class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    //MARK: properties
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let releaseYearLabel = UILabel()
    let ratingLabel = UILabel()
    
    //MARK: lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    private func setupViews() {
        setupPosterView()
        setupLabels()
        setupConstraints()
    }

    private func setupPosterView() {
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.layer.cornerRadius = 20
        posterImageView.clipsToBounds = true
        contentView.addSubview(posterImageView)
    }

    private func setupLabels() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        releaseYearLabel.font = UIFont.systemFont(ofSize: 14)
        ratingLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping

        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseYearLabel)
        contentView.addSubview(ratingLabel)
    }

    private func setupConstraints() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseYearLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding * 7),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            releaseYearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseYearLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            releaseYearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            releaseYearLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: releaseYearLabel.bottomAnchor, constant: 5),
            ratingLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    //MARK: Configuration
    func configure(with movie: Movie, isEvenRow: Bool) {
        titleLabel.text = movie.title
        releaseYearLabel.text = String(movie.releaseDate.prefix(4))
        ratingLabel.text = "Rating: \(movie.rating)"
        
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
        
        contentView.backgroundColor = isEvenRow ? UIColor.darkGray : UIColor.lightGray
        titleLabel.textColor = isEvenRow ? UIColor.white : UIColor.black
        releaseYearLabel.textColor = isEvenRow ? UIColor.white : UIColor.black
        ratingLabel.textColor = isEvenRow ? UIColor.white : UIColor.black
    }
}
