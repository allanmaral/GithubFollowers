//
//  GFLoadingView.swift
//  GHFollowers
//
//  Created by Allan Amaral on 08/11/22.
//

import UIKit

final class GFLoadingView: UIView {
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimating() {
        fadeIn()
        activityIndicator.startAnimating()
    }

    private func configure() {
        backgroundColor = .systemBackground
        configureActivityIndicator()
    }

    private func configureActivityIndicator() {
        addSubview(activityIndicator)

        activityIndicator.startAnimating()

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func fadeIn() {
        alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0.8
        }
    }
}
