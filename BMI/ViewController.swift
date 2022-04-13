//
//  ViewController.swift
//  BMI
//
//  Created by Nurkanat Klimov on 03.04.2022.
//

import UIKit



class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var maleButton: UIButton!
    @IBOutlet private weak var femaleButton: UIButton!
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var heightStepper: UIStepper!
    @IBOutlet private weak var weightStepper: UIStepper!
    @IBOutlet private weak var ageSlider: UISlider!
    @IBOutlet private weak var calculateButton: UIButton!
    
    private var isMale: Bool = false
    
    let initialColor = UIColor(red: 85/255, green: 132/255, blue: 172/255, alpha: 0.7)
    let finalColor = UIColor(red: 187/255, green: 100/255, blue: 100/255, alpha: 1.0)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        heightStepper.value = 150.0
        weightStepper.value = 50.0
        ageSlider.value = 30.0
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        calculateButton.addTarget(self, action: #selector(calculateBmi), for: .touchUpInside)
    }
    
    @IBAction func maleButtonTapped(_ sender: UIButton) {
        isMale = true
        femaleButton.configuration?.baseBackgroundColor = initialColor
        sender.configuration?.baseBackgroundColor = finalColor
    }
    
    @IBAction func femaleButtonTapped(_ sender: UIButton) {
        isMale = false
        maleButton.configuration?.baseBackgroundColor = initialColor
        sender.configuration?.baseBackgroundColor = finalColor
    }
    
    @IBAction func heightStepperTapped(_ sender: UIStepper) {
        heightLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func weightStepperTapped(_ sender: UIStepper) {
        weightLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func ageDidSlide(_ sender: UISlider) {
        ageLabel.text = "\(Int(sender.value))"
    }
    
    @objc func calculateBmi() {
        let heightValue = Double(heightStepper.value / 100)
        let weightValue = Double(weightStepper.value)
        let gender = isMale ? "Mister" : "Miss"
        let bmiOutput = weightValue / (heightValue * heightValue)
        let bmiResult = String(format: "%.1f", bmiOutput)
        
        
        print("Hi, \(gender) \(lastNameTextField.text!). Your current BMI result is \(bmiResult)")

        
        let resultColor: UIColor = {
            var color = UIColor()
            switch bmiOutput {
            case 0..<16:
                color = .link
            case 16..<17:
                color = .cyan
            case 17..<18.5:
                color = .systemYellow
            case 18.5..<25:
                color = .green
            case 25..<30:
                color = .yellow
            case 30..<35:
                color = .systemPink
            case 35..<40:
                color = .red
            default:
                break
            }
            
            return color
        }()
        
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.intro = "Dear \(gender)"
        controller.name = "\(firstNameTextField.text!) \(lastNameTextField.text!)"
        controller.bmiResult = bmiResult
        controller.indicatorColor = resultColor
        
        navigationController?.modalTransitionStyle = .coverVertical
        navigationController?.modalPresentationStyle = .pageSheet
        present(controller, animated: true)
        
    }
}


    // MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        textField.autocorrectionType = .no
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var isOk = false
        if let text = textField.text {
            if text.count > 2 {
                textField.resignFirstResponder()
                isOk = true
            }
        } else {
            isOk = false
        }
        
        return isOk
    }
}

