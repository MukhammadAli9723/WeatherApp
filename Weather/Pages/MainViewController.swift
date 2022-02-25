//
//  MainViewController.swift
//  Weather
//
//  Created by Muhammadali Yulbarsbekov on 23/02/22.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    let shared = WeatherNetworkManager.shared
    var news:  [WeatherData] = []
    
    let cityLabel               = UILabel()
    let weatherView             = UIView()
    let weatherConditionImage   = UIImageView()
    let dayName                 = UILabel()
    let dayDate                 = UILabel()
    let todatTextLabel             = UILabel()
    let weatherTemperatureLabel = UILabel()
    let temperatureLookLike     = UILabel()
    let todayLabel              = UILabel()
    let showSevenClimaButton    = UIButton()
    let currentLocationButton   = UIButton()
    let searchTextField         = UITextField()
    
    var weatherListDaily = [ListData]()
    
    
    weak var weatherInfoCollectionView:  UICollectionView!

    
    private let cellID = "WeatherCell"
    
    var weatherManager = WeatherNetworkManager()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Today's Weather"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appMainColor]
        self.navigationController?.navigationBar.tintColor = UIColor.appMainColor
        
        view.backgroundColor = .appWhite
        initView()
        showTodayWeather()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
        }
        
        
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        
    }
    
    func initView(){
        
        view.addSubview(searchTextField)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.searchTextField.frame.height))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = UITextField.ViewMode.always
        searchTextField.placeholder = "search"
        searchTextField.backgroundColor = .appMainColor
        searchTextField.layer.cornerRadius = 10
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY).multipliedBy(0.3)
            make.left.equalTo(view.snp.left).inset(20)
            make.height.equalTo(view.snp.height).multipliedBy(0.06)
            make.width.equalTo(view.snp.width).multipliedBy(0.6)
            
        }
        
        view.addSubview(currentLocationButton)
        currentLocationButton.contentMode = .scaleAspectFit
        currentLocationButton.setImage(UIImage(named: "location"), for: .normal)
        currentLocationButton.addTarget(self, action: #selector(getCurrentLocation), for: .touchUpInside)
        currentLocationButton.layer.cornerRadius = 30
        currentLocationButton.backgroundColor = .appMainColor
        currentLocationButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.centerY.equalTo(searchTextField.snp.centerY)
            make.top.equalTo(searchTextField.snp.top)
            make.right.equalTo(view.snp.right).inset(20)
            
        }
        
        view.addSubview(weatherView)
        weatherView.layer.cornerRadius = 20
        weatherView.backgroundColor = .appMainColor
        weatherView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
        }
        
        weatherView.addSubview(weatherConditionImage)
        weatherConditionImage.image = UIImage(named: "sun")
        weatherConditionImage.contentMode = .scaleAspectFit
        weatherConditionImage.clipsToBounds = true
        weatherConditionImage.snp.makeConstraints { make in
            make.left.equalTo(weatherView.snp.left).inset(10)
            make.top.equalTo(weatherView.snp.top).offset(-15)
            make.height.equalTo(weatherView.snp.height).multipliedBy(0.5)
            make.width.equalTo(weatherView.snp.width).multipliedBy(0.4)
            
        }
        
        weatherView.addSubview(cityLabel)
        cityLabel.text = "Andijan"
        cityLabel.textColor = .appWhite
        cityLabel.font = .boldSystemFont(ofSize: 40)
        cityLabel.font = UIFont(name: "Courier New", size: 40)
        cityLabel.snp.makeConstraints { make in
            make.left.equalTo(weatherConditionImage.snp.left)
            make.top.equalTo(weatherConditionImage.snp.bottom).offset(10)
        }

        
        view.addSubview(todatTextLabel)
        todatTextLabel.text = ""
        todatTextLabel.textColor = .appWhite
        todatTextLabel.font = .boldSystemFont(ofSize: 12)
        todatTextLabel.font = UIFont(name: "Courier New", size: 15)
        todatTextLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(5)
            make.left.equalTo(cityLabel.snp.left)
        }
        weatherView.addSubview(weatherTemperatureLabel)
        weatherTemperatureLabel.text = "27°"
        weatherTemperatureLabel.textAlignment = .center
        weatherTemperatureLabel.font = .boldSystemFont(ofSize: 50)
        weatherTemperatureLabel.font = UIFont(name: "Courier New", size: 50)
        weatherTemperatureLabel.textColor = .appWhite
        weatherTemperatureLabel.snp.makeConstraints { make in
            make.centerY.equalTo(weatherConditionImage.snp.centerY)
            make.right.equalTo(weatherView.snp.right).inset(10)
            make.left.equalTo(weatherConditionImage.snp.right).inset(-10)

        }
 
        
        view.addSubview(todayLabel)
        todayLabel.text = "Today and Next 7 day's Weather"
        todayLabel.textColor = .appTextColor
        todayLabel.font = .boldSystemFont(ofSize: 20)
        todayLabel.font = UIFont(name: "Courier New", size: 20)
        todayLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            
            
        }
         
        
    }
    func showTodayWeather(){
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.register(TodaysWeatherCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 10
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(todayLabel.snp.left)
            make.top.equalTo(todayLabel.snp.bottom).offset(20)
            make.width.equalTo(weatherView.snp.width)
            make.height.equalTo(weatherView.snp.height)
        }
        self.weatherInfoCollectionView = collectionView
    
    }
    
    @objc func getCurrentLocation(sender: UIButton){
            self.locationManager.startUpdatingLocation()
         
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherListDaily.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID , for: indexPath) as! TodaysWeatherCell

        let conditionId = weatherListDaily[indexPath.item].weather?[0].id ?? 200
        let dataOFToday = weatherListDaily[indexPath.item].dt_txt ?? ""
        let temp = weatherListDaily[indexPath.item].main?.temp ?? 0
        let weatherData = WeatherModel(conditionId: conditionId, cityName: "", temperature: temp, dataOFToday: dataOFToday)
        
        
        cell.setItem(item: weatherData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 20) * 2/3  , height:  (view.frame.height) * 1/3)
    }
    
}


// MARK: - UItextFieldDelegate
extension MainViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    private func textFieldDidEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Typing something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
            print(city)
        }
    }
}

// MARK: - WeatherManagerDelegate

extension MainViewController: WeatherManagerDelegate {
    func didUpdateWeatherAll(list: [ListData]) {
        DispatchQueue.main.async {
            self.weatherListDaily = list
            self.weatherInfoCollectionView.reloadData()
        }
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            
        self.weatherTemperatureLabel.text = "\(weather.temperatureString)"

        self.weatherConditionImage.image = UIImage(systemName: weather.conditionName)
        self.cityLabel.text = "\(weather.cityName)"
        
            self.todatTextLabel.text = "\(weather.dataOFToday)"
 
        }
        
    }
    
    
}// MARK: - CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            let lan = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("lsn \(lan) lot \(lon)")
            weatherManager.fetchWeatherByLocation(latitude: lan, longitute: lon)
            locationManager.stopUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

