//
//  ImmersiveView.swift
//  Puzzle
//
//  Created by Vladyslav Arkavenko on 12/07/2023.
//

import SwiftUI
import AVKit
import ARKit
import RealityKit
import RealityKitContent

// TODO: Try to find Anchor with enough space to minimize overlap?
// let anchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: [0.2, 0.2]))

// TODO: Fix PuzzlePiecePicker placement
// TODO: Try maybe another window with grid of 3d models?

struct LevelView: View {
    @Environment(ViewModel.self) private var model
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State var musicPlayer: AVAudioPlayer?
    
    var body: some View {
        if model.selectedLevel == nil {
            EmptyView()
        } else {
//            ZStack() {
//                PuzzlePiecePicker()
                
                RealityView { content in
                    do {
                        let scene = try await Entity(
                            named: model.selectedLevel!.sceneName,
                            in: realityKitContentBundle
                        )
                        content.add(scene)
                    } catch {
                        print("Failed to load scene for \(model.selectedLevel!.name)", error)
                    }
                }
                .onChange(of: scenePhase) { _, newPhase in
                    if newPhase == .active {
                        do {
                            musicPlayer = try AVAudioPlayer(contentsOf: model.selectedLevel!.music)
                            
                            musicPlayer!.numberOfLoops = -1
                            musicPlayer!.play()
                        } catch {
                            print("Failed to load music for \(model.selectedLevel!.name)", error)
                        }
                    } else if newPhase == .background {
                        musicPlayer?.stop()
                    }
                }
//            }
        }
    }
}

#Preview("Christmas Eve") {
    var model = ViewModel()
    model.selectedLevel = .christmas_eve
    return LevelView().environment(model)
}
