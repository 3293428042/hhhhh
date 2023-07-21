//
//  Level.swift
//  Puzzle
//
//  Created by Vladyslav Arkavenko on 18/07/2023.
//

import Foundation

enum Level: String, Identifiable, CaseIterable, Equatable {
    case christmas_eve
    
    var id: Self { self }
    var name: String {
        switch self {
        case .christmas_eve:
            "Christmas Eve"
        }
    }
    
    var thumbName: String {
        switch self {
        case .christmas_eve:
            "christmasEveThumb"
        }
    }
    var sceneName: String {
        switch self {
        case .christmas_eve:
            "christmas_eve"
        }
    }
    var pieces: [String] {
        switch self {
        case .christmas_eve:
            [
                "christmas_tree",
                "present_square_red_1",
                "present_round_white_1"
            ]
        }
    }
    
    
    var music: URL {
        switch self {
        case .christmas_eve:
            Bundle.main.url(forResource: "we-wish-you-a-merry-christmas", withExtension: "mp3")!
        }
    }
        
}
