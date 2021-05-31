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
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 700...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud"
            default:
                return "cloud"
        }
    }
}
