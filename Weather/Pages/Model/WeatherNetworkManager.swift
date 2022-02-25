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
    func didUpdateWeatherAll(list: [ListData])
}
struct WeatherNetworkManager {
    static let shared = WeatherNetworkManager()
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?appid=e243a2e1a7472a42b640da337fc42123&units=metric"
    //
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        
    }
    func fetchWeatherByLocation(latitude: CLLocationDegrees, longitute: CLLocationDegrees){
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
                    if let weather = self.parseJSON(weatherData: safeData) {                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                    if let list = self.parseAllJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeatherAll(list: list)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseAllJSON(weatherData: Data) -> [ListData]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            
            
            
            return decodeData.list
        } catch {
            print(error)
            return nil
        }
            
    }
    
    func parseJSON(weatherData: Data ) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            
            
            
            
            let id = decodeData.city?.id ?? 0
            let countryName = decodeData.city?.country ?? ""
            let temperatura = decodeData.list?[0].main?.temp ?? 0
            let data = decodeData.list?[0].dt_txt

            let weather = WeatherModel(conditionId: id, cityName: countryName, temperature: temperatura, dataOFToday: data ?? "")
            
            
            return weather
            
        }
        catch {
            print(error)
            return nil
        }
        
    }
}


