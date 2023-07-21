//
//  ViewModel.swift
//  Puzzle
//
//  Created by Vladyslav Arkavenko on 18/07/2023.
//

import SwiftUI
import Observation

@Observable
class ViewModel {
    var selectedLevel: Level? = nil
    
    let pieceSize: Double = 500
    let pieceSpacing: Double = 100
    let pieceMaxDisplayedCount: Int = 5
}
