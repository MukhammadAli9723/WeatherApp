//
//  WeatherData.swift
//  Weather
//
//  Created by Muhammadali Yulbarsbekov on 24/02/22.
//

import UIKit

//struct WeatherData: Codable {
//    let name: String
//    let main: Main
//    let weather: [Weather]
//
//}
//
//struct Main: Codable {
//    let temp: Double
//}
//
//struct Weather: Codable {
//    let id  : Int
//    let main: String
//    let description: String
//    let icon: String
//}


//
struct WeatherData: Codable {

    let cod:       String?
    let message:    Int?
    let cnt:        Int?
    let list:       [ListData]?
    let city:       CityData?
}

struct ListData: Codable {

    let dt:         Int?
    let main:       MainData?
    let weather:    [Weather_Data]?
    let clouds:     Clouds?
    let wind:       Wind?
    let visibility: Int?
    let sys:        Sys?
    let dt_txt:     String?

}

struct MainData: Codable{
    let temp:       Double?
    let feels_like: Double?
 

}

struct Weather_Data: Codable {

    let id:          Int?
    let main:        String?
    let description: String?
    let icon:        String?

}

struct Clouds: Codable {

    let all:         Int?
}

struct Wind: Codable {

    let speed:      Double?
    let deg:        Int?
    let gust:       Double?
}

struct Sys: Codable {

    let pod:        String?
}

struct CityData: Codable {

    let id:         Int?
    let name:       String?
    let country:    String?
    let population: Int?
    let timezone:   Int?
    let sunrise:    Double?
    let sunset:     Double?
}

struct CordData: Codable {

    let lat: Int?
    let lon: Int?
}
