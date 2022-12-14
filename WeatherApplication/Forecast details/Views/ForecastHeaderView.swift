//
//  ForecastHeaderView.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 08.12.2022.
//

import UIKit

class ForecastHeaderView: UIView {
    
    private let currentDateLabel = UILabel()
    private let conditionImage = UIImageView()
    private let tempView = InfoView(imageName: "thermometer.sun.fill")
    private let humidityView = InfoView(imageName: "humidity.fill")
    private let windView = InfoView(imageName: "wind")
    private let infoStackView = UIStackView()
    private let conditionStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        constrainViews()
    }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    private func configureViews() {
        backgroundColor = UIColor(named: "weatherBlue")
        configureCurrentDateLabel()
        configureConditionImage()
        configureStackViews()
    }
    
    private func constrainViews() {
        setupCurrentDateLabel()
        setupConditionImage()
        setupConditionStackView()
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
    }

}

//MARK: - Configure views

extension ForecastHeaderView {
    private func configureCurrentDateLabel() {
        currentDateLabel.text = "Fri, 15 Dec"
        currentDateLabel.font = UIFont.systemFont(ofSize: 20)
        currentDateLabel.textColor = .white
    }
    
    private func configureConditionImage() {
        conditionImage.image = UIImage(systemName: "cloud.sun.bolt")
        conditionImage.tintColor = .white
        conditionImage.contentMode = .scaleAspectFit
    }
    
    private func configureStackViews() {
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillProportionally
        infoStackView.spacing = 10
        infoStackView.addArrangedSubviews(tempView, humidityView, windView)
        
        conditionStackView.axis = .horizontal
        conditionStackView.alignment = .center
        conditionStackView.distribution = .equalSpacing
        conditionStackView.spacing = 30
        conditionStackView.addArrangedSubviews(conditionImage,
                                               infoStackView)
    }
}


// MARK: - Constrain views

extension ForecastHeaderView {
    private func setupCurrentDateLabel() {
        addConstrainedSubview(currentDateLabel)
        NSLayoutConstraint.activate([
            currentDateLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            currentDateLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            currentDateLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func setupConditionImage() {
        NSLayoutConstraint.activate([
            conditionImage.heightAnchor.constraint(equalToConstant: 150),
            conditionImage.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func setupConditionStackView() {
        addConstrainedSubview(conditionStackView)
        NSLayoutConstraint.activate([
            conditionStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            conditionStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
