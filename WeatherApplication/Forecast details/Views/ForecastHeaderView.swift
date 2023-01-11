//
//  ForecastHeaderView.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 08.12.2022.
//

import UIKit

class ForecastHeaderView: UIView {
    
    private let currentDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Fri, 15 Dec"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let conditionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud.sun.bolt")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let conditionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        return stackView
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    private let tempView = InfoView(imageName: "thermometer.sun.fill")
    private let humidityView = InfoView(imageName: "humidity.fill")
    private let windView = InfoView(imageName: "wind")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        constrainViews()
    }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    private func configureViews() {
        backgroundColor = UIColor(named: "weatherBlue")
        configureStackViews()
    }
    
    private func constrainViews() {
        constrainCurrentDateLabel()
        constrainConditionImage()
        constrainConditionStackView()
    }
}

// MARK: - Configure views

extension ForecastHeaderView {
    private func configureStackViews() {
        infoStackView.addArrangedSubviews(tempView,
                                          humidityView,
                                          windView)
        conditionStackView.addArrangedSubviews(conditionImage,
                                               infoStackView)
    }
}


// MARK: - Constrain views

extension ForecastHeaderView {
    private func constrainCurrentDateLabel() {
        addConstrainedSubview(currentDateLabel)
        NSLayoutConstraint.activate([
            currentDateLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            currentDateLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            currentDateLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func constrainConditionImage() {
        NSLayoutConstraint.activate([
            conditionImage.heightAnchor.constraint(equalToConstant: 150),
            conditionImage.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func constrainConditionStackView() {
        addConstrainedSubview(conditionStackView)
        NSLayoutConstraint.activate([
            conditionStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            conditionStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
