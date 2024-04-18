//
//  ContentView.swift
//  Calculator
//
//  Created by changhyen yun on 4/18/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var memos: [Memo]
    
    @State var isSheetShowing: Bool = false
    @State var memoText: String = ""
    @State var memoColor: String = "#0902FA"
    let colors: [String] = ["#0902FA", "#02FA25","#fc0b03","#ba03fc","#fc037b"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(memos) { memo in
                    HStack {
                        VStack(alignment: .leading){
                            Text("\(memo.text)").font(.title)
                            Text("\(memo.created.toString)").font(.body).padding(.top)
                        }
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(hex: memo.color))
                    .shadow(radius: 3)
                    .padding()
                    .contextMenu{
                        ShareLink(item: memo.text)
                        Button{delete(memo: memo)} label: {
                            Image(systemName: "trash.slash")
                            Text("삭제")
                        }
                    }

                }
            }
            .listStyle(.plain)
            .navigationTitle("Memo")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: MemoAddView(memoText: $memoText, memoColor:  $memoColor, colors: colors)) {
                        Text("추가")
                    }
                }
            }
        }
    }
    
    private func delete(memo: Memo) {
        context.delete(memo)
    }
}

#Preview {
    ContentView().modelContainer(for: Memo.self, inMemory: true)
}

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}

extension Color {
    init(hex: String) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
            }

            self.init(
                .sRGB,
                red: Double(r) / 255,
                green: Double(g) / 255,
                blue:  Double(b) / 255,
                opacity: Double(a) / 255
            )
        }
}
