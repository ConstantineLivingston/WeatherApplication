//
//  ViewContrller.swift
//  WeatherApplication
//
//  Created by Konstantin Bratchenko on 08.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let someView = ForecastHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(someView)
        someView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        someView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        someView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
       
    }
}
