//
//  InfoView.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 08.12.2022.
//

import UIKit
import LazyHelper

class InfoView: UIView {
    
    let imageView = UIImageView()
    let label = UILabel()
    private let stackView = UIStackView()
    
    init(imageName: String, labelText: String? = "Condition info") {
        super.init(frame: .zero)
        imageView.image = UIImage(systemName: imageName)
        label.text = labelText
        configureViews()
        constrainViews()
    }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    private func configureViews() {
        imageView.tintColor = .white
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24)
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.addArrangedSubviews(imageView,
                                      label)
    }
    
    private func constrainViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        addPinnedSubview(stackView)
    }
}
