//
//  DetailViewController.swift
//  BMI
//
//  Created by Nurkanat Klimov on 06.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak private var introLabel: UILabel!
    @IBOutlet weak private var fullName: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 35)
        label.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var intro: String?
    var name: String?
    var bmiResult: String?
    var indicatorColor: UIColor?
    var circlePath = UIBezierPath()
    let shape = CAShapeLayer()
    
    let bmiTitles = ["Your BMI is considered UNDERWEIGHT", "Your BMI is considered NORMAL", "Your BMI is considered OVERWEIGHT", "Your BMI is considered OBESE"]
    let messages = ["Try to avoid relying on high-calorie foods full of saturated fat and sugar – such as chocolate, cakes and sugary drinks – to gain weight.", "Maintaining a healthy weight may lower the risk of developing certain health conditions, including cardiovascular disease and type 2 diabetes. Waist-to-hip ratio, waist-to-height ratio, and body fat percentage measurements can provide a more complete picture of any health risks.", "You should consult with their healthcare provider and consider making lifestyle changes through healthy eating and fitness to improve your health indicators.", "You should consult with their healthcare provider and consider making lifestyle changes through healthy eating and fitness to improve your health indicators."]
    
    
    var counter = 0  {
        didSet {
            let image = UIImage(systemName: "envelope.open.fill", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 25))
            self.messageButton.setImage(image, for: .normal)
            self.messageButton.tintColor = .green
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(systemName: "envelope.fill", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 25))
        self.messageButton.setImage(image, for: .normal)
        self.messageButton.tintColor = .orange
        
        resultLabel.center = CGPoint(x: view.center.x, y: view.center.y - 70)
        
        if let intro = intro,
           let name = name,
           let bmiResult = bmiResult,
           let indicatorColor = indicatorColor {
            introLabel.text = intro
            fullName.text = name
            createShape()
            shape.strokeColor = indicatorColor.cgColor
            view.addSubview(resultLabel)
            resultLabel.text = bmiResult
        }
        
    }
    private func createShape() {
        circlePath = UIBezierPath(arcCenter: CGPoint(x: view.center.x, y: view.center.y - 40), radius: 100, startAngle: 0, endAngle: .pi, clockwise: false)
        shape.path = circlePath.cgPath
        shape.fillColor = UIColor(red: 216/255, green: 210/255, blue: 203/255, alpha: 1.0).cgColor
        shape.strokeColor = UIColor.lightGray.cgColor
        shape.lineWidth = 25
        view.layer.addSublayer(shape)
    }
    
    
    // MARK: - Actions
    
    @IBAction private func messageTapped(_ sender: UIButton) {
        
        var title = String()
        var message = String()
        
        guard let result = Double(resultLabel.text!) else {
            return
        }
        
        switch result {
        case 0..<18.5:
            title = bmiTitles[0]
            message = messages[0]
        case 18.5..<25:
            title = bmiTitles[1]
            message = messages[1]
        case 25..<30:
            title = bmiTitles[2]
            message = messages[2]
        default:
            title = bmiTitles[3]
            message = messages[3]
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
        
        counter += 1
    }
}
