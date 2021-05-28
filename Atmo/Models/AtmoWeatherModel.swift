//
//  AtmoWeatherModel.swift
//  Atmo
//
//  Created by Mark Philips on 2021-05-28.
//

import Foundation

/*
 * Struct model that is responsible for holding the parsed
 * JSON data from [AtmoWeatherData]
 *
 * @author Mark Philips
 */
struct AtmoWeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let conditionDescription: String
    let feelsLike: Double
    let humidity: Int
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch (conditionId) {
            case 200...232:
                return "cloudy"
            case 300...321:
                return "cloudy with drizzle"
            case 500...531:
                return "cloudy with rain"
            case 600...622:
                return "snowing"
            case 700...781:
                return "foggy"
            case 800:
                return "Sunny"
            default:
                return "cloudy"
        }
    }
}
