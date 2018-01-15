//
//  ViewController.swift
//  datasetML
//
//  Created by Nasir Uddin on 2018-01-14.
//  Copyright © 2018 Nasir Uddin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var flowerTypeLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    let sepalLength = ["4", "4.5", "5", "5.5", "6", "6.5", "7"]
    let sepalWidth = ["1", "2", "3", "4", "4.5", "5", "5.5", "6", "6.5", "7"]
    let petalLength = ["1", "2", "3", "4", "4.5", "5", "5.5", "6", "6.5", "7"]
    let petalWidth = ["0.25", "0.5", "1", "2", "3", "4", "4.5", "5", "5.5", "6", "6.5", "7"]
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
    }
    
    func triggerPrediction() {
        let rowString1 = sepalLength[pickerView.selectedRow(inComponent: 0)]
        let rowString2 = sepalWidth[pickerView.selectedRow(inComponent: 1)]
        let rowString3 = sepalLength[pickerView.selectedRow(inComponent: 2)]
        let rowString4 = sepalWidth[pickerView.selectedRow(inComponent: 3)]
        
        if let value1 = NumberFormatter().number(from: rowString1)?.doubleValue, let value2 = NumberFormatter().number(from: rowString2)?.doubleValue, let value3 = NumberFormatter().number(from: rowString3)?.doubleValue, let value4 = NumberFormatter().number(from: rowString4)?.doubleValue {
            
            let model = iris()
            
            let input = irisInput(sepal_length__cm_: value1, sepal_width__cm_: value2, petal_length__cm_: value3, petal_width__cm_: value4)
            
            if let prediction = try? model.prediction(input: input) {
                
                let name = self.prettyName(index: prediction.iris_class)
                print("The iris flower is a \(name)")
                self.flowerTypeLabel.text = "\(name)"
                self.setImage(index: prediction.iris_class)
            }
        }
        
    }
    
    func prettyName(index: Int64) -> String {
        var name = "not an iris flower."
        
        if index == 0 {
            name = "Setosa"
        } else if index == 1 {
            name = "Versicolor"
        } else if index == 2 {
            name = "Virginica"
        }
        
        return name
    }
    
    func setImage(index: Int64) {
        if index == 0 {
            self.imageView.image = UIImage(named: "iris-setosa.jpg")
        } else if index == 1 {
            self.imageView.image = UIImage(named: "iris-versicolor.jpg")
        } else if index == 2 {
            self.imageView.image = UIImage(named: "iris-virginica.jpg")
        }
    }
    
    
}

extension ViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.triggerPrediction()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var selectedComponent = sepalLength
        if component == 1 {
            selectedComponent = sepalWidth
        } else if component == 2 {
            selectedComponent = petalLength
        } else if component == 3 {
            selectedComponent = petalWidth
        }
        
        return "\(selectedComponent[row])"
    }
}

extension ViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4 // sepal width / length, petal width / length
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count: Int = 0
        if component == 0 {
            count = sepalLength.count
        } else if component == 1 {
            count = sepalWidth.count
        } else if component == 2 {
            count = petalLength.count
        } else if component == 3 {
            count = petalWidth.count
        }
        
        return count
    }
    
    
}






