//
//  WeatherApiModel.swift
//  TzOpenWeather
//
//  Created by Степан Харитонов on 13.01.2022.
//

import Foundation

// MARK: - WeatherContainer
class WeatherContainer: Codable {
    let message: Int?
    let cod: String
    let cnt: Int
    let list: [List]
    let city: City

    init(message: Int?, cod: String, cnt: Int, list: [List], city: City) {
        self.message = message
        self.cod = cod
        self.cnt = cnt
        self.list = list
        self.city = city
    }
}

// MARK: - City
class City: Codable {
    let sunset: Int
    let country: String
    let id: Int
    let coord: Coord
    let population, timezone, sunrise: Int
    let name: String

    init(sunset: Int, country: String, id: Int, coord: Coord, population: Int, timezone: Int, sunrise: Int, name: String) {
        self.sunset = sunset
        self.country = country
        self.id = id
        self.coord = coord
        self.population = population
        self.timezone = timezone
        self.sunrise = sunrise
        self.name = name
    }
}

// MARK: - Coord
class Coord: Codable {
    let lat, lon: Double

    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}

// MARK: - List
class List: Codable {
    let clouds: Clouds
    let wind: Wind
    let dt: Int
    let snow: Snow?
    let dtTxt: String
    let main: MainClass
    let weather: [Weather]
    let pop: Double
    let sys: Sys
    let visibility: Int

    enum CodingKeys: String, CodingKey {
        case clouds, wind, dt, snow
        case dtTxt = "dt_txt"
        case main, weather, pop, sys, visibility
    }

    init(clouds: Clouds, wind: Wind, dt: Int, snow: Snow?, dtTxt: String, main: MainClass, weather: [Weather], pop: Double, sys: Sys, visibility: Int) {
        self.clouds = clouds
        self.wind = wind
        self.dt = dt
        self.snow = snow
        self.dtTxt = dtTxt
        self.main = main
        self.weather = weather
        self.pop = pop
        self.sys = sys
        self.visibility = visibility
    }
}

// MARK: - Clouds
class Clouds: Codable {
    let all: Int

    init(all: Int) {
        self.all = all
    }
}

// MARK: - MainClass
class MainClass: Codable {
    let humidity: Int
    let feelsLike, tempMin, tempMax, temp: Double
    let pressure: Int
    let tempKf: Double
    let seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case temp, pressure
        case tempKf = "temp_kf"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }

    init(humidity: Int, feelsLike: Double, tempMin: Double, tempMax: Double, temp: Double, pressure: Int, tempKf: Double, seaLevel: Int, grndLevel: Int) {
        self.humidity = humidity
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.temp = temp
        self.pressure = pressure
        self.tempKf = tempKf
        self.seaLevel = seaLevel
        self.grndLevel = grndLevel
    }
}

// MARK: - Snow
class Snow: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }

    init(the3H: Double) {
        self.the3H = the3H
    }
}

// MARK: - Sys
class Sys: Codable {
    let pod: Pod

    init(pod: Pod) {
        self.pod = pod
    }
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
class Weather: Codable {
    let id: Int
    let main: String
    let icon: String
    let weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case id, main, icon
        case weatherDescription = "description"
    }

    init(id: Int, main: String, icon: String, weatherDescription: String) {
        self.id = id
        self.main = main
        self.icon = icon
        self.weatherDescription = weatherDescription
    }
}

// MARK: - Wind
class Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double

    init(speed: Double, deg: Int, gust: Double) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
}
