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
    case divide = "/"
    case multiply = "X"
    case equal = "="
    case decimal = "."
    case clear = "C"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .green
        case .clear:
            return .red
        default:
            return .gray
        }
    }
}

enum Operator {
    case add, sub, multi, div, none
}

struct ContentView: View {
    @State var value = "0"
    @State var currentOperation: Operator = .none
    @State var runningNumber = 0
    @State var temp:[String] = []
    
    let btns: [[CalcBtn]] = [
        [.seven, .eight, .nine, .divide],
        [.four, .five, .six, .multiply],
        [.one, .two, .three, .subtract],
        [.decimal, .zero, .clear, .add],
        [.equal],
    ]
    
    var body: some View {
     
        VStack {
            List(temp, id: \.self) { temp in
                
                Text(temp)
            }
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
                                .frame(
                                    width: self.buttonWidth(item: item),
                                    height: self.buttonHeight()
                                )
                                .background(item.buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(self.buttonWidth(item: item)/2)
                        })
                        
                    }
                }
                .padding(.bottom, 3)
            }
        }
    }
    
    func onPress(btn: CalcBtn) {
        print(Operator.add)
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
                    temp.append(" \(runningValue) + \(currentValue) = \(runningValue + currentValue)")
                case .sub: self.value = "\(runningValue - currentValue)"
                    temp.append(" \(runningValue) - \(currentValue) = \(runningValue + currentValue)")
                case .multi: self.value = "\(runningValue * currentValue)"
                    temp.append(" \(runningValue) X \(currentValue) = \(runningValue + currentValue)")
                case .div: self.value = "\(runningValue / currentValue)"
                    temp.append(" \(runningValue) ÷ \(currentValue) = \(runningValue + currentValue)")
                case .none:
                    break
                }
            }
            if btn != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
            self.temp = []
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
    
    func buttonWidth(item: CalcBtn) -> CGFloat {
        if item == .equal {
            return ((UIScreen.main.bounds.width - (4*12)))
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }

    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

#Preview {
    ContentView()
}
