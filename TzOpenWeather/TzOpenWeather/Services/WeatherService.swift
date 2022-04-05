//
//  WeatherService.swift
//  TzOpenWeather
//
//  Created by Степан Харитонов on 13.01.2022.
//

import Foundation
import Alamofire

final class WeatherService {
    
    let baseUrl = "http://api.openweathermap.org"
    let apiKey = "f69d8dde38e74625ccb2bcd032d3828a"
    
    func getWeather(nameTown: String, completion: @escaping(WeatherContainer)->()) {
        
        let path = "/data/2.5/forecast"
        let url = baseUrl + path
        
        let params: [String:String] = [
            "q" : nameTown,
            "appid" : apiKey,
            "units" : "metric",
            "lang" : "ru"
        ]
        
        AF.request(url, method: .get, parameters: params).responseData {response in
            
            guard let jsonData = response.data else { return }
            
            do {
                let weatherContainer = try JSONDecoder().decode(WeatherContainer.self, from: jsonData)
                
                completion(weatherContainer)
            } catch {
                print(error)
            }
        }
    }

}
