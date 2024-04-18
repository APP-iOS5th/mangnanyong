//
//  MemoStore.swift
//  Calculator
//
//  Created by changhyen yun on 4/22/24.
//
import Foundation
import SwiftUI
import SwiftData

@Model
final class Memo {
    var id: UUID = UUID()
    var text: String
    var created: Date
    var color: String
    
    init(text: String, color: String) {
        self.text = text
        self.color = color
        created = Date()
    }
}
