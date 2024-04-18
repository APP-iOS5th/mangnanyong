//
//  ContentView.swift
//  Calculator
//
//  Created by changhyen yun on 4/18/24.
//

import SwiftUI

enum CalcBtn: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "*"
    case equal = "="
    case clear = "C"
}

enum Operator {
    case add, sub, multi, div, none
}

struct ContentView: View {
    @State var value = "0"
    @State var currentOperation: Operator = .none
    @State var runningNumber = 0
    
    let btns: [[CalcBtn]] = [
        [, "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        [".", "0", "c", "+"],
        ["="],
    ]
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text(value)
                    .bold()
                    .font(.system(size: 100))
            }
            .padding()
            
            ForEach(btns, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id:\.self) { item in
                        Button(action: {
                            self.onPress(btn: item)
                        }, label: {
                            Text(item.rawValue)
                                .font(.system(size: 32))
                        })
                        
                    }
                }
                .padding(.bottom, 3)
            }
        }
    }
    
    func onPress(btn: CalcBtn) {

        switch btn {
        case .add, .subtract, .multiply, .divide, .equal:
            if btn == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if btn == .subtract {
                self.currentOperation = .sub
                self.runningNumber = Int(self.value) ?? 0
            }
            else if btn == .multiply {
                self.currentOperation = .multi
                self.runningNumber = Int(self.value) ?? 0
            }
            else if btn == .divide {
                self.currentOperation = .div
                self.runningNumber = Int(self.value) ?? 0
            }
            else if btn == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .sub: self.value = "\(runningValue - currentValue)"
                case .multi: self.value = "\(runningValue * currentValue)"
                case .div: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            if btn != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
            break
        default:
            let num = btn.rawValue
            if self.value == "0" {
                value = num
            }
            else {
                self.value = "\(self.value)\(num)"
            }
        }
    }
}



#Preview {
    ContentView()
}
