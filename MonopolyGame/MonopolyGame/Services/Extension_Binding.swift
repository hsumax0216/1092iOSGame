//
//  Extension_Binding.swift
//  MonopolyGame
//
//  Created by 徐浩恩 on 2021/6/30.
//

import SwiftUI

extension Binding where Value: MutableCollection, Value.Index == Int {
    func element(_ idx: Int) -> Binding<Value.Element> {
        return Binding<Value.Element>(
            get: {
                return self.wrappedValue[idx]
        }, set: { (value: Value.Element) -> () in
            self.wrappedValue[idx] = value
        })
    }
}
