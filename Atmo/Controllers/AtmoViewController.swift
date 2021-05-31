//
//  AtmoViewController.swift
//  Atmo
//
//  Created by Mark Philips on 2021-05-28.
//

import UIKit

class AtmoViewController: UIViewController {
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var weatherConditionImage: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var weatherConditionLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
