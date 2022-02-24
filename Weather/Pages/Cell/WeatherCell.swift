//
//  WeatherCell.swift
//  Weather
//
//  Created by Muhammadali Yulbarsbekov on 24/02/22.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    let climateImage = UIImageView()
    let dayLabel     = UILabel()
    let dayName      = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 30
        configureView()
    }
    
    func configureView(){
        
        self.addSubview(climateImage)
        climateImage.image = UIImage(named: "sun")
        climateImage.contentMode = .scaleAspectFit
        climateImage.clipsToBounds = true
        climateImage.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            
        }
        
        self.addSubview(dayLabel)
        dayLabel.text = "27"
        dayLabel.font = .boldSystemFont(ofSize: 40)
        dayLabel.font = UIFont(name: "Courier New", size: 40)
        dayLabel.textColor = .appWhite
        dayLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(climateImage.snp.bottom).offset(10)
            
        }
        self.addSubview(dayName)
        dayName.text = "Sun"
        dayName.font = .boldSystemFont(ofSize: 20)
        dayName.font = UIFont(name: "Courier New", size: 30)
        dayName.textColor = .appWhite
        dayName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dayLabel.snp.bottom).offset(10)
            
        }
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
