//
//  WeatherManager.swift
//  Weather
//
//  Created by Muhammadali Yulbarsbekov on 24/02/22.
//

import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(weather: WeatherModel)
}
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?lat=35&lon=139&appid=e243a2e1a7472a42b640da337fc42123&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        
    }
    func fetchWeather(latitude: CLLocation, longitute: CLLocation){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitute)"
        performRequest(with: urlString)
        
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        let weatherVC = MainViewController()
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
        func parseJSON(weatherData: Data )-> WeatherModel? {
            let decoder = JSONDecoder()
            do {
                let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
                
                //            let cod = decodeData.code
                //            let message = decodeData.message
                //            let cnt = decodeData.cnt
                
                let id = decodeData.city.id
                let countryName = decodeData.city.name
                let temperatura = decodeData.list[1].main.temp
                let weather = WeatherModel(conditionId: id, cityName: countryName, temperature: temperatura)
                
                return weather
                
            }
            catch {
            print(error)
            return nil
        }

}
}


