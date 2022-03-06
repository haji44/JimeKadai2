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

    private var sign: Sign = .plus

    enum Sign {
        case plus, minus, multiply, divide
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func didSegmentChange(_ sender: UISegmentedControl) {
        let types: [Sign] = [.plus, .minus, .multiply, .divide]
        sign = types[sender.selectedSegmentIndex]
    }
    @IBAction private func didCalcuratorButtoneTaped(_ sender: UIButton) {
        let number1 = Float(textField1.text ?? "") ?? 0
        let number2 = Float(textField2.text ?? "") ?? 0
        let result: String = String(calcurate(num1: number1, num2: number2))
        resultLabel.text = result
    }
    private func calcurate(num1: Float, num2: Float) -> Float {
        switch sign {
        case .plus:
            return num1 + num2
        case .minus:
            return num1 - num2
        case .multiply:
            return num1 * num2
        case .divide:
            return num1 / num2
        }
    }
}
