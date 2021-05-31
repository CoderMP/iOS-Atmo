//
//  AtmoViewController.swift
//  Atmo
//
//  Created by Mark Philips on 2021-05-28.
//

import UIKit
import CoreLocation

class AtmoViewController: UIViewController {
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var weatherConditionImage: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var weatherConditionLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the CoreLocation's delegate
        locationManager.delegate = self
        
        // Request the user's location
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // Set the searchTextField & AtmoWeatherManager delegates
        searchTextField.delegate = self
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

//MARK: - CLLocationManagerDelegate
extension AtmoViewController: CLLocationManagerDelegate {
    @IBAction func locationPressed(_ sender: UIButton) {
        // Check to see whether or not the LocationManager's location is nil
        if (locationManager.location != nil) {
            // request the location
            locationManager.requestLocation()
            
            // Visualize the use of location services being used to the user via animating the location button
            UIView.transition(with: locationButton!, duration: 0.5, options: .transitionFlipFromRight, animations: {
                self.locationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
            }, completion: nil)
        }
    }
    
    /*
     * Delegate function that is responsible for handling execution logic based on updated locations from
     * the CLLocationManager
     *
     * @param manager The CLLocationManager that will use the delegate function
     * @param locations The array of locations captured via the CLLocationManager's requestLocation()
     *
     * @author Mark Philips
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // Stop the LocationManager from getting a new location
            locationManager.stopUpdatingLocation()
            
            // Extract the latitiude and longitude from the most accurate location entry
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            
            // TODO: Fetch the weather conditions for the current location
            
            if let locationFill = UIImage(systemName: "location.fill") {
                locationButton.setImage(locationFill, for: .normal)
            }
        }
    }
    
    /*
     * Delegate function that is responsible for handling any errors that occur with the LocationManager
     *
     * @param manager The CLLocationManager that will use the delegate function
     * @param error The error that occurred
     *
     * @author Mark Philips
     */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Print the error to the console
        print(error)
    }
}
