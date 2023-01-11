//
//  DailyCellContentView.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 14.12.2022.
//

import UIKit

class DailyCellContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        
        var dayText: String? = ""
        var tempText: String? = ""
        var conditionImage: UIImage?
        
        func makeContentView() -> UIView & UIContentView {
            DailyCellContentView(configuration: self)
        }
    }
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let conditionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var configuration: UIContentConfiguration
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 60)
    }
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        constrainViews()
        configure(configuration: configuration)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration
        else { return }
        
        dayLabel.text = configuration.dayText
        tempLabel.text = configuration.tempText
        conditionImage.image = configuration.conditionImage
    }
}

// MARK: - Constrain Views

extension DailyCellContentView {
    private func constrainViews() {
        addConstrainedSubviews(dayLabel,
                               tempLabel,
                               conditionImage)
        
        NSLayoutConstraint.activate([
            dayLabel.widthAnchor.constraint(equalToConstant: 50),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tempLabel.widthAnchor.constraint(equalToConstant: 120),
            tempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            conditionImage.heightAnchor.constraint(equalToConstant: 50),
            conditionImage.widthAnchor.constraint(equalToConstant: 50),
            conditionImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            conditionImage.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

extension UITableViewCell {
    func dailyConfiguration() -> DailyCellContentView.Configuration {
        DailyCellContentView.Configuration()
    }
}
