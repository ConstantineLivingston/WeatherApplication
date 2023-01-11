//
//  InfoView.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 08.12.2022.
//

import UIKit
import LazyHelper

class InfoView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    init(imageName: String, labelText: String? = "Condition info") {
        super.init(frame: .zero)
        imageView.image = UIImage(systemName: imageName)
        label.text = labelText
        constrainViews()
    }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    private func constrainViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        stackView.addArrangedSubviews(imageView,
                                      label)
        addPinnedSubview(stackView)
    }
}
