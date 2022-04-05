//
//  FirstLoadViewController.swift
//  TzOpenWeather
//
//  Created by Степан Харитонов on 13.01.2022.
//

import UIKit

class FirstLoadViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var weatherUpTitle: UILabel!
    @IBOutlet weak var townTextField: UITextField!
    
    var visualEffectView: UIView?
    private var gradient : CAGradientLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleSettings()
        blurMotion()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.gradient = CAGradientLayer()
        self.gradient?.frame = self.view.bounds
        self.gradient?.colors = [ UIColor.systemTeal.cgColor, UIColor.orange.cgColor]
        self.gradient?.locations = [ 0 as NSNumber, 1 as NSNumber]
        self.gradient?.startPoint = CGPoint.init(x: 0, y: 0)
        self.gradient?.endPoint = CGPoint.init(x: 0, y: 1)
        self.view.layer.insertSublayer(self.gradient!, at: 0)

        animateLayer()
        animateStartPoint()
        animateEndPoint()
    }
    
    //MARK: AlertNotification
    private func alertNotification() {
        let titleText = "Упс, что-то пошло не так"
        let messageText = "Возможно, вы неправильно ввели название города или не ввели его совсем"
        let titleActionButton = "Ввести заново"
        
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
           
        let actionalert = UIAlertAction(
            title: titleActionButton,
            style: .cancel,
            handler: nil)
           
        alert.addAction(actionalert)
        present(alert, animated: true, completion: nil)
    }
 
    //MARK: Settings
    private func styleSettings() {
        self.weatherUpTitle.textColor = .white
        self.weatherUpTitle.layer.shadowColor = UIColor.black.cgColor
        self.weatherUpTitle.layer.shadowRadius = 5
        self.weatherUpTitle.layer.shadowOpacity = 0.6
        self.weatherUpTitle.layer.shadowOffset = CGSize.zero
        
    }
    
    //MARK: Blur
    private func blurMotion() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            visualEffectView.frame = self.view.frame
            self.view.insertSubview(visualEffectView, at: 0)
            self.visualEffectView = visualEffectView
        visualEffectView.alpha = 0.95
    }
    
    //MARK: Gradient Animate
    private func animateLayer(){

        let fromColors = self.gradient?.colors
        let toColors: [AnyObject] = [ UIColor.purple.cgColor, UIColor.red.cgColor]
        self.gradient?.colors = toColors
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")

        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = 8.00
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
        animationStPoint.duration = 6.00
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
        animationEndPoint.duration = 6.00
        animationEndPoint.autoreverses = true
        animationEndPoint.repeatCount = Float.infinity
        animationEndPoint.fillMode = CAMediaTimingFillMode.forwards
        animationEndPoint.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.gradient?.add(animationEndPoint, forKey: "animateEndPoint")
    }
    
    //MARK: IBAction
    @IBAction func buttonConfirm(_ sender: Any) {
        let nameSegue = "firstEntrySegue"
        
        if townTextField.text != nil && townTextField.text != "" {
            TownClass.townArray.append(TownClass.init(townName: townTextField.text!))
            performSegue(withIdentifier: nameSegue, sender: nil)
        } else {
           alertNotification()
        }
    }
    
}
