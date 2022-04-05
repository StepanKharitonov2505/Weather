//
//  WeatherListViewController.swift
//  TzOpenWeather
//
//  Created by Степан Харитонов on 13.01.2022.
//

import UIKit

class WeatherListViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var townSelectCollectionView: UICollectionView!
    @IBOutlet weak var mainInfoSeclectedTownView: UIView!
    @IBOutlet weak var nameTown: UILabel!
    @IBOutlet weak var tempNow: UILabel!
    @IBOutlet weak var conditionsWeather: UILabel!
    @IBOutlet weak var weatherHourCollectionView: UICollectionView!
    @IBOutlet weak var weatherWeekView: UIView!
    @IBOutlet weak var weatherWeekTableView: UITableView!
    
    private var weatherService = WeatherService()
    private var weatherInfo: WeatherContainer?
    private var townArray = TownClass.townArray
    private let degree = "°"
    private var gradient : CAGradientLayer?
    private let borderColor = UIColor.init(cgColor: .init(red: 229, green: 229, blue: 234, alpha: 0.5)).cgColor
    
    override func viewDidAppear(_ animated: Bool) {
        self.gradient = CAGradientLayer()
        self.gradient?.frame = self.view.bounds
        self.gradient?.colors = [ UIColor.systemMint.cgColor, UIColor.green.cgColor]
        self.gradient?.locations = [ 0 as NSNumber, 1 as NSNumber]
        self.gradient?.startPoint = CGPoint.init(x: 0, y: 0)
        self.gradient?.endPoint = CGPoint.init(x: 0, y: 1)
        self.view.layer.insertSublayer(self.gradient!, at: 0)

        animateLayer()
        animateStartPoint()
        animateEndPoint()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preLoadWeatherSettings()
        registerCell()
        loadWeather()
        
    }
    
    private func registerCell() {
        self.townSelectCollectionView.register(UINib(nibName: "SelectTownCell", bundle: nil), forCellWithReuseIdentifier: "SelectTownCell")
            self.townSelectCollectionView.dataSource = self
            self.townSelectCollectionView.delegate = self

        self.weatherHourCollectionView.register(UINib(nibName: "WeatherHourCell", bundle: nil), forCellWithReuseIdentifier: "WeatherHourCell")
            self.weatherHourCollectionView.dataSource = self
            self.weatherHourCollectionView.delegate = self

        self.weatherWeekTableView.register(UINib(nibName: "WeatherWeekCell", bundle: nil), forCellReuseIdentifier: "WeatherWeekCell")
            self.weatherWeekTableView.dataSource = self
            self.weatherWeekTableView.delegate = self
    }
    
    private func loadWeather() {
        for i in 0..<(self.townArray.count) {
            weatherService.getWeather(nameTown: townArray[i].townName) { [weak self] weatherInfo in
                guard let self = self else { return }
                self.weatherInfo = weatherInfo
                self.afterLoadWeatherSettings()
                self.weatherHourCollectionView.reloadData()
                self.weatherWeekTableView.reloadData()
            }
        }
    }
    
    //MARK: Settings style
    private func preLoadWeatherSettings() {
        let cornerRadius: CGFloat = 15
        self.mainInfoSeclectedTownView.layer.cornerRadius = 25
        self.weatherWeekView.layer.cornerRadius = cornerRadius
        self.weatherHourCollectionView.layer.cornerRadius = cornerRadius
        self.townSelectCollectionView.layer.cornerRadius = townSelectCollectionView.frame.height/3
        self.weatherHourCollectionView.layer.cornerRadius = cornerRadius
        self.weatherWeekTableView.layer.cornerRadius = 10
        
        self.mainInfoSeclectedTownView.layer.shadowColor = UIColor.black.cgColor
        self.mainInfoSeclectedTownView.layer.shadowRadius = 5
        self.mainInfoSeclectedTownView.layer.shadowOffset = CGSize.zero
        self.mainInfoSeclectedTownView.layer.shadowOpacity = 0.8
        
        self.mainInfoSeclectedTownView.layer.borderColor = borderColor
        self.mainInfoSeclectedTownView.layer.borderWidth = 0.5
    }
    
    private func afterLoadWeatherSettings() {
        self.nameTown.text = weatherInfo?.city.name
        let tempNow: String = String(describing: weatherInfo!.list[0].main.temp).components(separatedBy: ".")[0]
        
        self.tempNow.text = tempNow + degree
        self.conditionsWeather.text =  weatherInfo!.list[0].weather[0].weatherDescription
    }
    
    //MARK: Gradient Animate
    private func animateLayer(){

        let fromColors = self.gradient?.colors
        let toColors: [AnyObject] = [ UIColor.link.cgColor, UIColor.white.cgColor]
        self.gradient?.colors = toColors
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")

        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = 7.00
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.delegate = self

        self.gradient?.add(animation, forKey:"animateGradientColors")
      }
    
    private func animateStartPoint() {
        let fromStartPoint = self.gradient?.startPoint
        let toStartPoint = CGPoint.init(x: 1, y: 0.5)
        self.gradient?.startPoint = toStartPoint
        let animationStPoint: CABasicAnimation = CABasicAnimation(keyPath: "startPoint")
        animationStPoint.fromValue = fromStartPoint
        animationStPoint.toValue = toStartPoint
        animationStPoint.duration = 5.00
        animationStPoint.autoreverses = true
        animationStPoint.repeatCount = Float.infinity
        animationStPoint.fillMode = CAMediaTimingFillMode.forwards
        animationStPoint.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.gradient?.add(animationStPoint, forKey: "animateStartPoint")
    }
    
    private func animateEndPoint() {
        let fromEndPoint = self.gradient?.endPoint
        let toEndPoint = CGPoint.init(x: 0, y: 0)
        self.gradient?.endPoint = toEndPoint
        let animationEndPoint: CABasicAnimation = CABasicAnimation(keyPath: "endPoint")
        animationEndPoint.fromValue = fromEndPoint
        animationEndPoint.toValue = toEndPoint
        animationEndPoint.duration = 5.00
        animationEndPoint.autoreverses = true
        animationEndPoint.repeatCount = Float.infinity
        animationEndPoint.fillMode = CAMediaTimingFillMode.forwards
        animationEndPoint.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.gradient?.add(animationEndPoint, forKey: "animateEndPoint")
    }
}

//MARK: Extension next 4 day
extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberItemsArrayDay = weatherInfo?.list[8...39] else { return 0 }
        return numberItemsArrayDay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherWeekCell", for: indexPath) as? WeatherWeekCell else {
            return UITableViewCell()
        }
        let weekSliceArray = (self.weatherInfo?.list[8..<(self.weatherInfo?.list.count)!])!
        
        let weekArray: Array<List> = Array(weekSliceArray)
        
        let weekDay = weekArray[indexPath.row]
        
        let dateComponent = weekDay.dtTxt.components(separatedBy: " ")
        let dateComponentTwo = dateComponent[0].components(separatedBy: "-")
        let dateComponentThree = dateComponent[1].components(separatedBy: ":")
        
        cell.monthName.text = descriptionMonth(month: dateComponentTwo[1])   
        cell.numberDay.text = dateComponentTwo[2]
        cell.time.text = dateComponentThree[0]+":00"
        
        let tempWeek = String(describing: weekDay.main.temp).components(separatedBy: ".")[0]
        cell.weekTempDay.text = tempWeek + degree
        cell.bVWeek.layer.cornerRadius = cell.bVWeek.frame.height/4
        cell.bVWeek.layer.borderColor = borderColor
        cell.bVWeek.layer.borderWidth = 0.5
        
        cell.layer.opacity = 0
        UIView.animate(withDuration: 0.2, animations: {cell.layer.opacity = 1})
        return cell
    }
    
    private func descriptionMonth(month: String) -> String {
        switch month {
        case "01": return "января"
        case "02": return "февраля"
        case "03": return "марта"
        case "04": return "апреля"
        case "05": return "мая"
        case "06": return "июня"
        case "07": return "июля"
        case "08": return "августа"
        case "09": return "сентября"
        case "10": return "ноября"
        case "11": return "октября"
        case "12": return "декабря"
        default:
            return ""
        }
    }
}

//MARK: Extension Town/Today
extension WeatherListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == townSelectCollectionView {
            let numberItems = townArray.count
            return numberItems
        } else {
            guard let dayArrayWeather = weatherInfo?.list[0...8] else { return 0 }
            
            return dayArrayWeather.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == townSelectCollectionView {
            guard let cellTown = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectTownCell", for: indexPath) as? SelectTownCell else {
                return UICollectionViewCell()
            }
            let town = self.townArray[indexPath.item]
            cellTown.nameTown.text = town.townName
            cellTown.bViewTown.layer.cornerRadius = cellTown.bViewTown.frame.height/4
            
            cellTown.bViewTown.layer.borderWidth = 0.5
            cellTown.bViewTown.layer.borderColor = borderColor
            
            cellTown.bViewTown.layer.shadowColor = UIColor.black.cgColor
            cellTown.bViewTown.layer.shadowOffset = CGSize.zero
            cellTown.bViewTown.layer.shadowRadius = 2
            cellTown.bViewTown.layer.shadowOpacity = 0.8
            
            cellTown.layer.opacity = 0
            UIView.animate(withDuration: 0.2, animations: {cellTown.layer.opacity = 1})
            
            return cellTown

        } else {
            guard let cellHour = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherHourCell", for: indexPath) as? WeatherHourCell else {
                return UICollectionViewCell()
            }
            let dayArrayWeather = self.weatherInfo?.list[0...8]
            
            let hour = dayArrayWeather?[indexPath.item]
            let tempHour = String(describing: hour!.main.temp).components(separatedBy: ".")[0]
            cellHour.tempTitle.text = tempHour + degree
            
            let dateTimeComponent = hour?.dtTxt.components(separatedBy: " ")
            let dateTimeComponentTwo = dateTimeComponent?[1].components(separatedBy: ":")
            cellHour.timeTitle.text = (dateTimeComponentTwo?[0])!+":00"
            cellHour.weatherTitleHour.text = hour?.weather[0].weatherDescription
            
            cellHour.bViewHour.layer.cornerRadius = 15
            
            cellHour.bViewHour.layer.shadowColor = UIColor.black.cgColor
            cellHour.bViewHour.layer.shadowOffset = CGSize.zero
            cellHour.bViewHour.layer.shadowRadius = 2
            cellHour.bViewHour.layer.shadowOpacity = 0.8
            
            cellHour.bViewHour.layer.borderWidth = 0.5
            cellHour.bViewHour.layer.borderColor = borderColor
            
            cellHour.layer.opacity = 0
            UIView.animate(withDuration: 0.2, animations: {cellHour.layer.opacity = 1})
            
            return cellHour
        }
        
    }
    
    //MARK: Layout cell Town/Today
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == weatherHourCollectionView {
            let layoutHour = self.weatherHourCollectionView.frame.height
            return CGSize(width: layoutHour, height: layoutHour)
        } else {
            let layoutWidthTown = (self.townSelectCollectionView.frame.width-12)/4
            let layoutHeightTown = self.townSelectCollectionView.frame.height
            return CGSize(width: layoutWidthTown, height: layoutHeightTown)
        }
    }

}
