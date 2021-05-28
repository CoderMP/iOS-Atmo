//
//  AtmoWeatherManager.swift
//  Atmo
//
//  Created by Mark Philips on 2021-05-28.
//

import Foundation
import CoreLocation

/*
 * Delegate protocol with callback functions for AtmoWeatherManager
 *
 * @author Mark Philips
 */
protocol AtmoWeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: AtmoWeatherManager, weather: AtmoWeatherModel)
    func didFailWithError(error: Error)
}

/*
 * Struct that is responsible for handling weather data retrieval and parsing
 * from OpenWeather's API
 *
 * @author Mark Philips
 */
struct AtmoWeatherManager {
    // Set the weatherURL and manager delegate
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=YOUR_API_KEY_HERE&units=metric"
    var delegate: AtmoWeatherManagerDelegate?
    
    /*
     * Function that is responsible for retrieving the weather data for a location via it's name
     *
     * @param cityName The name of the city to retrieve the weather for
     * @author Mark Philips
     */
    func fetchWeather(cityName: String) {
        let url = "\(weatherURL)&q=\(cityName.replacingOccurrences(of: " ", with: "%20"))"
        
        performRequest(with: url)
    }
    
    /*
     * Function that is responsilbe for retrieving the weather data for a location via it's
     * Latitude and Longitude retrieved from [CoreLocation]
     *
     * @param latitude The location's latitude in degrees
     * @param longitude The location's longitude in degrees
     * @author Mark Philips
     */
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let url = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        
        performRequest(with: url)
    }
    
    /*
     * Function that is responsible for creating the URLSession and DataTask
     * to request JSON data from OpenWeather's API via the [urlString], and
     * parse it via [AtmoWeatherData].
     *
     * @param urlString The URL to use for the Session's DataTask
     * @author Mark Philips
     */
    func performRequest(with urlString: String) {
        // Create the URL object
        if let url = URL(string: urlString) {
            // Create the URLSession
            let session = URLSession(configuration: .default)
            
            // Assign a DataTask to the session
            let task = session.dataTask(with: url) { (data, response, error) in
                // check for any errors
                if (error != nil) {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                // Otherwise, catch the retrieved data and parse it
                if let safeData = data {
                    if let weather = self.parseJson(weatherData: safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // Start the Session's DataTask
            task.resume()
        }
    }
    
    /*
     * Function that is responsible for parsing the received JSON data from
     * OpenWeather's API and encoding it to the [AtmoWeatherModel]
     *
     * @param weatherData The received weather data from OpenWeather's API
     * @return An initialized AtmoWeatherModel object containing the decoded JSON data
     *
     * @author Mark Philips
     */
    func parseJson(weatherData: Data) -> AtmoWeatherModel? {
        // Declare & initialize a JSONDecoder
        let decoder = JSONDecoder()
        
        do {
            // Attempt to decode the weatherData via the JSONDecoder
            let decodedData = try decoder.decode(AtmoWeatherData.self, from: weatherData)
            
            // Set the decoded data to temp variables
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let feelsLike = decodedData.main.feels_like
            let humidity = decodedData.main.humidity
            let name = decodedData.name
            let desc = decodedData.weather[0].description
            
            // Initialize a WeatherModel object with the decoded JSON Data
            let weatherModel = AtmoWeatherModel(
                conditionId: id,
                cityName: name,
                temperature: temp,
                conditionDescription: desc,
                feelsLike: feelsLike,
                humidity: humidity
            )
            
            //Return the initialized weatherModel
            return weatherModel
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
