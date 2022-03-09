//
//  ViewController.swift
//  JimeKadai2
//
//  Created by kitano hajime on 2022/03/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var textField1: UITextField!
    @IBOutlet private weak var textField2: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var operatorSegmentedControl: UISegmentedControl!

    private enum ErrorMessage: Error {
        case notNumeric, divideByZero, unkwon

        var message: String {
            switch self {
            case .notNumeric:
                return "Text is not allowed as input"
            case .divideByZero:
                return "Can't dived by zero"
            case .unkwon:
                return "Something went wrong"
            }
        }
    }

    private enum Calculation: Int {
        case plus, minus, mitiply, divide
        
        func calculate(_ first: Double, _ second: Double) -> Result<Double, ErrorMessage> {
            switch self {
            case .plus:
                return .success(first + second)
            case .minus:
                return .success(first - second)
            case .mitiply:
                return .success(first * second)
            case .divide:
                guard !second.isZero else { return .failure(.divideByZero)}
                return .success(first / second)
            }
        }
    }

    @IBAction private func didCalcuratorButtoneTaped(_ sender: UIButton) {
        guard let first = textField1.text.flatMap({ Double($0) }),
              let second = textField2.text.flatMap({ Double($0) }) else {
                  resultLabel.text = ErrorMessage.notNumeric.message
            return
        }
        guard let calculation = Calculation(rawValue: operatorSegmentedControl.selectedSegmentIndex) else {
            fatalError(ErrorMessage.unkwon.message)
        }
        switch calculation.calculate(first, second) {
        case .success(let result):
            resultLabel.text = String(result)
        case .failure(let error):
            resultLabel.text = error.message
        }
    }
}
