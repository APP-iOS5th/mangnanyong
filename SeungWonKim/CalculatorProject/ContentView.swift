//
//  ContentView.swift
//  CalculatorProject
//
//  Created by 김승원 on 4/18/24.
//

import SwiftUI

struct CalculatorButton: View {
    let text: String
    let textColor: Color?
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(text)
                .font(.title)
            //                .frame(width: 60, height: 60)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor((textColor != nil) ? textColor : .black)
                .background(Color.white)
                .border(Color.black)
        }
    }
}

struct ContentView: View {
    @State private var text = ""
    @State private var number: Int = 0
    @State private var totalNum: Int = 0
    var body: some View {
        VStack() {
            
            TextField("", text: $text)
                .frame(height: 60)
                .background(Color.gray)
                .multilineTextAlignment(.trailing)
            
            
            HStack() {
                CalculatorButton(text: "7", textColor: nil) {
                    self.text += "7"
                }
                CalculatorButton(text: "8", textColor: nil) {
                    self.text += "8"
                }
                CalculatorButton(text: "9", textColor: nil) {
                    self.text += "9"
                }
                CalculatorButton(text: "/", textColor: nil) {
                    
                }
            }
            HStack() {
                CalculatorButton(text: "4", textColor: nil) {
                    self.text += "4"
                }
                CalculatorButton(text: "5", textColor: nil) {
                    self.text += "5"
                }
                CalculatorButton(text: "6", textColor: nil) {
                    self.text += "6"
                }
                CalculatorButton(text: "X", textColor: nil) {
                    
                }
            }
            HStack() {
                CalculatorButton(text: "1", textColor: nil) {
                    self.text += "1"
                }
                CalculatorButton(text: "2", textColor: nil) {
                    self.text += "2"
                }
                CalculatorButton(text: "3", textColor: nil) {
                    self.text += "3"
                }
                CalculatorButton(text: "-", textColor: nil) {
                    
                }
            }
            HStack() {
                CalculatorButton(text: ".", textColor: nil) {
                    if (!self.text.contains(".") && self.text != "") {
                        self.text += "."
                    }
                }
                CalculatorButton(text: "0", textColor: nil) {
                    self.text += "0"
                }
                CalculatorButton(text: "C", textColor: .red) {
                    self.text = ""
                    totalNum = 0
                }
                CalculatorButton(text: "+", textColor: nil) {
                    if self.text != "" {
                        number = Int(self.text) ?? 0
                        self.text = ""
                        totalNum += number
                    }
                }
            }
            HStack() {
                CalculatorButton(text: "=", textColor: nil) {
                    if let enteredNumber = Int(self.text) {
                        self.text = "\(totalNum + enteredNumber)"
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
