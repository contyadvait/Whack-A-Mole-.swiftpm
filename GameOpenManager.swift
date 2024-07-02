//
//  GameOpenManager.swift
//  Whack-A-Mole
//
//  Created by Milind Contractor on 30/6/2024
//

import Foundation

final class GameOpening: ObservableObject {
    enum Action {
        case na
        case open
    }
    
    @Published private(set) var action: Action = .na
    func present() {
        guard !action.isPresented else { return }
        self.action = .open
    }
}

extension GameOpening.Action {
    var isPresented: Bool { self == .open }
}
