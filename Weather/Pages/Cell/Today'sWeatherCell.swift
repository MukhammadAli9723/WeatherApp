//
//  Today'sWeather.swift
//  Weather
//
//  Created by Muhammadali Yulbarsbekov on 24/02/22.
//

import UIKit

class TodaysWeatherCell: UICollectionViewCell {
   
    let tadayClimateImage               = UIImageView()
    let tadayTemperatureDegreeLabel     = UILabel()
    let hourLabel                       = UILabel()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTodayWeather()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setTodayWeather(){
        self.addSubview(tadayClimateImage)
        tadayClimateImage.image = UIImage(named: "sun")
        tadayClimateImage.contentMode = .scaleAspectFit
        tadayClimateImage.clipsToBounds = true
        tadayClimateImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            
        }
        
        self.addSubview(tadayTemperatureDegreeLabel)
        tadayTemperatureDegreeLabel.text = "27°"
        tadayTemperatureDegreeLabel.font = .boldSystemFont(ofSize: 30)
        tadayTemperatureDegreeLabel.font = UIFont(name: "Courier New", size: 30)
        tadayTemperatureDegreeLabel.textColor = .appWhite
        tadayTemperatureDegreeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tadayClimateImage.snp.bottom).offset(5)
            
        }
        self.addSubview(hourLabel)
        hourLabel.text = "02:00"
        hourLabel.font = .boldSystemFont(ofSize: 30)
        hourLabel.font = UIFont(name: "Courier New", size: 30)
        hourLabel.textColor = .appWhite
        hourLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.centerY).multipliedBy(0.2)
            
        }
        
        
    }
}
