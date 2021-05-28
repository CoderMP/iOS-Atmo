//
//  AtmoWeatherData.swift
//  Atmo
//
//  Created by Mark Philips on 2021-05-28.
//

import Foundation

/*
 * Struct that is responsible for using [Codable] type to help parse
 * the receieved JSON data from OpenWeather's API
 *
 * @author Mark Philips
 */
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

/*
 * Struct that is responsible for using the [Codable] type to
 * extract the temperature, humidity, and "feels like" JSON fields
 * from OpenWeather's API
 *
 * @author Mark Philips
 */
struct Main: Codable {
    let temp: Double
    let humidity: Int
    let feels_like: Double
}

/*
 * Struct that is responsible for using the [Codable] type to
 * extract the "type" of the weather (ID) and the "description"
 * of the weather (e.g. "raining")
 *
 * @author Mark Philips
 */
struct Weather: Codable {
    let id: Int
    let description: String
}
