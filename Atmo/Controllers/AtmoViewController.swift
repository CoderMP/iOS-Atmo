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
        
        // TODO: CoreLocation and AtmoWeatherManager delegate initialization
    }
}

//MARK: - UITextFieldDelegate
extension AtmoViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        // Trigger the textFieldDidEndEditing delegate function
        searchTextField.endEditing(true)
        
        // Check to see if the text field is empty
        if (searchTextField.text == "") {
            searchTextField.placeholder = "Enter a City Name"
        } else {
            UIView.transition(with: locationButton!, duration: 0.5, options: .transitionFlipFromRight, animations: {
                self.locationButton.setImage(UIImage(systemName: "location.north"), for: .normal)
            }, completion: nil)
        }
    }
    
    /*
     * Delegate function for the software keyboard's "return" key
     *
     * @param textField The UITextField to apply the delegate method to
     * @return True if the field should return, false otherwise
     *
     * @author Mark Philips
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        return true
    }
    
    /*
     * Delegate function for whether or not the UITextField should end editing
     *
     * @param textField The UITextField to apply the delegate method to
     * @return True if the field should end editing, False otherwise
     *
     * @author Mark Philips
     */
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text != "") {
            return true
        } else {
            searchTextField.placeholder = "Enter a City Name"
            return false
        }
    }
    
    /*
     * Delegate function for whether or not the UITextField ended editing
     *
     * @param textField The UITextField to apply the delegate method to
     *
     * @author Mark Philips
     */
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use the text from the UITextField to get the weather data for the desired city
        if let city = searchTextField.text {
            // TODO: WeatherManager fetch method
        }
        
        UIView.transition(with: locationButton!, duration: 0.5, options: .transitionFlipFromRight, animations: {
            self.locationButton.setImage(UIImage(systemName: "location.north"), for: .normal)
        }, completion: nil)
        
        // Clear the text field
        searchTextField.text = ""
    }
}
