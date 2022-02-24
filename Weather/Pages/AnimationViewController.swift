//
//  ViewController.swift
//  Weather
//
//  Created by Muhammadali Yulbarsbekov on 23/02/22.
//
import UIKit
import SnapKit
import Lottie

class AnimationViewController: UIViewController{
    let imageView  = UIImageView()
    let bottomView = UIView()
    var animationView: AnimationView?
    let appName    = UILabel()
    let appInfo    = UILabel()
    let sunImage   = UIImageView()
    let nextButton = UIButton()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.backgroundColor = UIColor.appMainColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    
        
        getStartedView()
    }
    func getStartedView(){
        animationView = .init(name: "weather_clouds")
        animationView?.frame = view.bounds
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1
        view.addSubview(animationView!)
        animationView?.play()
        animationView?.snp.makeConstraints({ make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.6)
        })
        
        view.addSubview(bottomView)
        bottomView.backgroundColor = .appWhite
        bottomView.layer.cornerRadius = 40
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(animationView?.snp.bottom as! ConstraintRelatableTarget).offset(10)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
        }
        
        bottomView.addSubview(appName)
        appName.text = "Weather"
        appName.textColor = .appTextColor
        appName.font = .boldSystemFont(ofSize: 35)
        appName.font = UIFont(name: "Courier New", size: 48)
        appName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bottomView.snp.top).offset(20)
        }
        bottomView.addSubview(appInfo)
        appInfo.text = "The Weather is most important thing in our life. We want to know all about what the weather today and next day...!"
        appInfo.textColor = .appTextInfoColor
        appInfo.font = .systemFont(ofSize: 15)
        appInfo.numberOfLines = 0
        appInfo.font = UIFont(name: "Courier New", size: 15)
        appInfo.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(appName.snp.bottom).offset(10)
        }
        
        bottomView.addSubview(sunImage)
        sunImage.image = UIImage(named: "sun")
        sunImage.contentMode = .scaleAspectFit
        sunImage.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().inset(-50)
            make.height.width.equalTo(150)
        }
        
        bottomView.addSubview(nextButton)
        nextButton.contentMode = .scaleAspectFit
        nextButton.setImage(UIImage(named: "right-arrows"), for: .normal)
        nextButton.layer.cornerRadius = 30
        nextButton.backgroundColor = .appMainColor
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(60)
            make.top.equalTo(appInfo.snp.bottom).offset(30)
            
        }
        
    }
    
    
    @objc func nextPage(){
        
        let vc = MainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

