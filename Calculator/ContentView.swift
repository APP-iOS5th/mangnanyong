
import SwiftUI

struct ContentView: View {
    // 계산기 버튼 목록
    let buttons = [
        ["AC", "+/-", "%"],
        ["7", "8", "9", "X"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
    
    // 현재 화면에 표시될 값
    @State var display = "0"
    // 첫 번째 피연산자
    @State var operand1 = ""
    // 두 번째 피연산자
    @State var operand2 = ""
    // 현재 선택된 연산자
    @State var operation = ""
    // 화면 초기화 여부
    @State var clearDisplay = true
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 10) {
                // 현재 화면에 표시될 값
                Text(display)
                    .foregroundStyle(.white)
                    .font(.system(size: 100))
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .padding(.trailing, 25)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                // 계산기 버튼 그리드
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                // 버튼 클릭 핸들러
                                handleButtonPress(button)
                            }, label: {
                                Text(button)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(buttonBackground(button))
                                    .foregroundColor(buttonColor(button))
                            })
                        }
                    }
                }
            }
            .padding(.top, 150)
        }
    }
    
    // 버튼 배경 색상
    func buttonBackground(_ button: String) -> Color {
        switch button {
        case "%", "X", "-", "+", "=":
            return Color.orange
        case "AC", "+/-":
            return Color.gray
        default:
            return Color.jcyun
        }
    }
    
    // 버튼 텍스트 색상
    func buttonColor(_ button: String) -> Color {
        switch button {
        case "AC", "+/-":
            return Color.black
        default:
            return Color.white
        }
    }
    
    // 계산기 버튼 클릭 핸들러
    func handleButtonPress(_ button: String) {
        switch button {
        case "C":
            // "C" 버튼: 화면 초기화
            display = "0"
            operand1 = ""
            operand2 = ""
            operation = ""
            clearDisplay = true
        case "X", "-", "+":
            // 연산자 버튼: 피연산자 설정
            operation = button
            operand1 = display
            clearDisplay = true
        case "=":
            // "=" 버튼: 계산 수행
            operand2 = display
            let result = calculate()
            display = result
            operand1 = ""
            operand2 = ""
            operation = ""
            clearDisplay = true
        default:
            // 숫자나 "." 버튼: 현재 값에 추가
            if clearDisplay {
                display = button
                clearDisplay = false
            } else {
                display += button
            }
        }
    }
    
    // 계산 함수
    func calculate() -> String {
        // 피연산자와 연산자 추출
        // 올바른 숫자 형식으로 변환하여 계산 수행
        if let num1 = Double(operand1), let num2 = Double(operand2) {
            switch operation {
            case "X":
                return String(num1 * num2)
            case "-":
                return String(num1 - num2)
            case "+":
                return String(num1 + num2)
            default:
                return "0"
            }
        } else {
            // 올바른 숫자 형식이 아닌 경우 "0"으로 처리
            return "0"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
