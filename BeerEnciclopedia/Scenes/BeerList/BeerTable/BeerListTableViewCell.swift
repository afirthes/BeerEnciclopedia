//
//  BeerListTableViewCell.swift
//  BeerEnciclopedia
//
//  Created by Afir Thes on 24.02.2023.
//

import UIKit

class BeerListTableViewCell: UITableViewCell {
    public static let reusableId = "cell"

    let thumbnailImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()

    private let beerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 1
        return label
    }()

    private let beerDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 6
        label.textAlignment = .left
        return label
    }()

    private let beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(beerImageView)
        contentView.addSubview(beerNameLabel)
        contentView.addSubview(beerDescriptionLabel)
        contentView.backgroundColor = .systemYellow

        beerImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(beerImageView.snp.height)
            make.height.equalTo(150)
        }

        beerNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(beerImageView.snp.trailing)
            make.trailing.equalToSuperview().offset(-8)
        }

        beerDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(beerNameLabel.snp.bottom)
            make.leading.equalTo(beerImageView.snp.trailing)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom).offset(-8)
        }
    }

    public func configure(title: String, image: String, description: String) {
        beerNameLabel.text = title
        beerDescriptionLabel.text = description
        beerImageView.load(url: URL(string: image)!)
    }
}
