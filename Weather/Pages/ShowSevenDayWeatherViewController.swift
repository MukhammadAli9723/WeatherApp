//
//  File.swift
//  Weather
//
//  Created by Muhammadali Yulbarsbekov on 24/02/22.
//

import UIKit

class ShowSevenDayWeatherViewController: UIViewController {
    
    private let cellID = "WeatherCell"
    
    weak var collectionView: UICollectionView!

    let weatherView  = UIView()
    let weatherImage = UIImageView()
    let dayName      = UILabel()
    let dayDate      = UILabel()
    let mounthLabel  = UILabel()
    let weatherTemperature  = UILabel()
    let temperatureLookLike = UILabel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Next 7 Day "
        view.backgroundColor = .appWhite
        showSevenWeather()
    }
  private func showSevenWeather(){
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 10
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY).multipliedBy(0.2)
            make.left.right.equalToSuperview().inset(5)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
            
        }
      self.collectionView = collectionView
      
      view.addSubview(weatherView)
      weatherView.layer.cornerRadius = 20
      weatherView.backgroundColor = .appMainColor
      weatherView.snp.makeConstraints { make in
          make.top.equalTo(collectionView.snp.bottom).offset(20)
          make.left.right.equalToSuperview().inset(20)
          make.height.equalTo(view.snp.height).multipliedBy(0.3)
      }
      
      weatherView.addSubview(weatherImage)
      weatherImage.image = UIImage(named: "sun")
      weatherImage.contentMode = .scaleAspectFit
      weatherImage.clipsToBounds = true
      weatherImage.snp.makeConstraints { make in
          make.left.equalTo(weatherView.snp.left).inset(10)
          make.top.equalTo(weatherView.snp.top).offset(-15)
          make.height.equalTo(weatherView.snp.height).multipliedBy(0.5)
          make.width.equalTo(weatherView.snp.width).multipliedBy(0.4)

      }
      weatherView.addSubview(weatherTemperature)
      weatherTemperature.text = "27°"
      weatherTemperature.textAlignment = .center
      weatherTemperature.font = .boldSystemFont(ofSize: 50)
      weatherTemperature.font = UIFont(name: "Courier New", size: 50)
      weatherTemperature.textColor = .appWhite
      weatherTemperature.snp.makeConstraints { make in
          make.centerY.equalTo(weatherImage.snp.centerY)
          make.right.equalTo(weatherView.snp.right).inset(10)
          make.left.equalTo(weatherImage.snp.right).inset(-10)

      }
      
      
      weatherView.addSubview(temperatureLookLike)
      temperatureLookLike.text = "Heavy Rain"
      temperatureLookLike.textColor = .appWhite
      temperatureLookLike.font = .boldSystemFont(ofSize: 20)
      temperatureLookLike.font = UIFont(name: "Courier New", size: 20)
      temperatureLookLike.snp.makeConstraints { make in
          make.top.equalTo(weatherImage.snp.bottom).offset(15)
          make.left.equalTo(weatherImage.snp.left)
          
      }
    }
    
    
}

extension ShowSevenDayWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WeatherCell
        cell.backgroundColor = .orange
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 20) / 2, height:  (view.frame.height) * 1/3)
    }
    
}
