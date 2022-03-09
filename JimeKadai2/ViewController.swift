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
        case notNumeric, divideByZero, unkwon, empty

        var message: String {
            switch self {
            case .notNumeric:
                return "Text is not allowed as input"
            case .divideByZero:
                return "Can't dived by zero"
            case .unkwon:
                return "Something went wrong"
            case .empty:
                return "Empty is not allowed"
            }
        }
    }

    private enum Calculation: Int {
        case plus, minus, mitiply, divide

        func calculate(_ first: String, _ second: String) -> Result<Double, ErrorMessage> {

            guard let first = Double(first),
                  let second = Double(second) else {
                      return .failure(.notNumeric)
            }

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
        if textField1.text?.isEmpty ?? true || textField2.text?.isEmpty ?? true {
            return resultLabel.text = ErrorMessage.empty.message
        }
        guard let first = textField1.text, let second = textField2.text else {
            return resultLabel.text = ErrorMessage.empty.message
        }
        guard let calculation = Calculation(rawValue: operatorSegmentedControl.selectedSegmentIndex) else {
            fatalError(ErrorMessage.unkwon.message)
        }
        switch calculation.calculate(first, second) {
        case .success(let result):
            resultLabel.text = "\(result)"
        case .failure(let error):
            resultLabel.text = error.message
        }
    }
}
