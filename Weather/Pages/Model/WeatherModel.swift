//
//  WeatherModel.swift
//  Weather
//
//  Created by Muhammadali Yulbarsbekov on 24/02/22.
//

import UIKit

struct WeatherModel {
    
    let conditionId: Int
    let cityName   : String
    let temperature: Double
    let dataOFToday: String
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        
        switch conditionId {
        case 200...232:
            return "bolt"
        case 300...321:
            return "drizzle"
        case 500...531:
            return "rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "fog"
        case 800:
            return "sun"
        case 801...804:
            return "CouldBolt"
            
        default:
            return "cloud"
            
        
            
        }
    }
}
