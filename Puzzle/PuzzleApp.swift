//
//  PuzzleApp.swift
//  Puzzle
//
//  Created by Vladyslav Arkavenko on 12/07/2023.
//

import SwiftUI

@main
struct PuzzleApp: App {
    @State private var model = ViewModel()
    
    @State var levelImmersionState: ImmersionStyle = .mixed
    
    // To always display piece picker in the center
    var pieacePickerWidth: Double {
        var displayPieceCount: Int = model.pieceMaxDisplayedCount
        if (model.selectedLevel != nil && model.selectedLevel!.pieces.count < model.pieceMaxDisplayedCount) {
            displayPieceCount = model.selectedLevel!.pieces.count
        }
        return model.pieceSize * Double(displayPieceCount) + model.pieceSpacing * Double(displayPieceCount - 1)
    }
    
    var body: some Scene {
        WindowGroup(id: "home") {
            HomeView()
                .environment(model)
        }
        .windowStyle(.plain)
        
        WindowGroup(id: "pieacePicker") {
            PiecePickerView()
                .environment(model)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: pieacePickerWidth, height: model.pieceSize, depth: model.pieceSize)
        
        ImmersiveSpace(id: "level") {
            LevelView()
                .environment(model)
        }
        .immersionStyle(selection: $levelImmersionState, in: .mixed)
    }
}
