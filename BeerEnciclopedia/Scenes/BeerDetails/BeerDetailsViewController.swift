//
//  BeerDetailsViewController.swift
//  BeerEnciclopedia
//
//  Created by Afir Thes on 24.02.2023.
//

import UIKit

class BeerDetailsViewController: UIViewController {
    private var scrollView = UIScrollView()

    private lazy var stackViewHeightConstraint = {
        let constraint = vStack.heightAnchor.constraint(equalToConstant: 0)
        constraint.isActive = true
        return constraint
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        return stack
    }()

    private var beer: Beer?

    init(with beer: Beer) {
        super.init(nibName: nil, bundle: nil)
        self.beer = beer
        imageView.load(url: URL(string: beer.imageUrl)!)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        title = beer?.name
    }

    private func setupUI() {
        guard let beer else { return }

        view.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.addSubview(vStack)

        imageView.snp.makeConstraints { make in
            make.left.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(imageView.snp.width)
        }

        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.equalToSuperview()
        }

        vStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
        }

        layoutVStackContents(with: beer)
    }

    private func layoutVStackContents(with beer: Beer) {
        vStack.addArrangedSubview(UIView())
        buildLable(title: beer.name, fontSize: 26, fontWeight: .bold)
        vStack.addArrangedSubview(UIView())
        buildLable(title: beer.description, fontSize: 16, fontWeight: .light)
        buildLable(title: "Ingredients: hops", fontSize: 24, fontWeight: .bold)
        for hop in beer.ingredients.hops {
            buildLable(title: hop.name)
        }
        buildLable(title: "Ingredients: malt", fontSize: 24, fontWeight: .bold)
        for malt in beer.ingredients.malt {
            buildLable(title: malt.name)
        }
        buildLable(title: "Food pairing", fontSize: 24, fontWeight: .bold)
        for food in beer.foodPairing {
            buildLable(title: food)
        }
    }

    private func buildLable(title: String, fontSize: Double = 18, fontWeight: UIFont.Weight = .regular) {
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.text = title
        lable.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        lable.textAlignment = .center

        vStack.addArrangedSubview(lable)

        lable.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let contentHeight = vStack.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        stackViewHeightConstraint.constant = contentHeight
    }
}
