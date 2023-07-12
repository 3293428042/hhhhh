//
//  PuzzleApp.swift
//  Puzzle
//
//  Created by Vladyslav Arkavenko on 12/07/2023.
//

import SwiftUI

@main
struct PuzzleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
