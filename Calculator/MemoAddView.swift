//
//  MemoAddView.swift
//  Calculator
//
//  Created by changhyen yun on 4/22/24.
//

import SwiftUI

struct MemoAddView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentation

    @Binding var memoText: String
    @Binding var memoColor: String
    let colors: [String]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("완료") {
                    add()
                }.disabled(memoText.isEmpty)
            }
            
            HStack {
                ForEach(colors, id: \.self ) { color in
                    Button { memoColor = color } label: {
                        HStack {
                            Spacer()
                            if color == memoColor {
                                Image(systemName: "checkmark.circle")
                            }
                            Spacer()
                        }
                        .padding().frame(height: 50).foregroundColor(.white).background(Color(hex:color)).shadow(radius: color == memoColor ? 8 : 0)
                    }
                }
            }
            
            Divider().padding()
            TextField("메모를 입력하세요", text: $memoText, axis: .vertical).padding().foregroundColor(.white).background(Color(hex: memoColor)).shadow(radius: 3)
            Spacer()
        }.padding()
    }
    private func add() {
        let newMemo = Memo(text: memoText, color: memoColor)
        context.insert(newMemo)
        memoText = ""
        // go back to previous page
        presentation.wrappedValue.dismiss()
    }
}


#Preview {
    MemoAddView( memoText: .constant("hi"), memoColor: .constant("#0902FA"), colors: ["#0902FA", "#02FA25"])
}

