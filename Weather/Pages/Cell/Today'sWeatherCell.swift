//
//  Today'sWeather.swift
//  Weather
//
//  Created by Muhammadali Yulbarsbekov on 24/02/22.
//

import UIKit

class TodaysWeatherCell: UICollectionViewCell {
    
    let todayClimateImage               = UIImageView()
    let todayTemperatureDegreeLabel     = UILabel()
    let hourLabel                       = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTodayWeather()
        self.backgroundColor = .appMainColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setItem(item: WeatherModel ){
        
        todayTemperatureDegreeLabel.text = "\(item.temperature)"
        todayClimateImage.image = UIImage(named: "\(item.conditionName)")
        hourLabel.text = "\(item.dataOFToday)"
        
    }
    
    func setTodayWeather(){
        self.addSubview(todayClimateImage)
        todayClimateImage.image = UIImage(named: "sun")
        todayClimateImage.contentMode = .scaleAspectFit
        todayClimateImage.clipsToBounds = true
        todayClimateImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            
        }
        
        self.addSubview(todayTemperatureDegreeLabel)
        todayTemperatureDegreeLabel.text = "27°"
        todayTemperatureDegreeLabel.font = .boldSystemFont(ofSize: 25)
        todayTemperatureDegreeLabel.font = UIFont(name: "Courier New", size: 25)
        todayTemperatureDegreeLabel.textColor = .appWhite
        todayTemperatureDegreeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(todayClimateImage.snp.bottom).offset(10)
            
        }
        self.addSubview(hourLabel)
        hourLabel.text = "022-02-25 03:00:00"
        hourLabel.font = .boldSystemFont(ofSize: 22)
        hourLabel.font = UIFont(name: "Courier New", size: 22)
        hourLabel.textColor = .appWhite
        hourLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.centerY).multipliedBy(0.2)
            
        }
        
        
    }
}
