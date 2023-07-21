//
//  TestModel.swift
//  Puzzle
//
//  Created by Vladyslav Arkavenko on 19/07/2023.
//

import SwiftUI
import RealityKit
import RealityKitContent

// TODO: Pitch is not relative to center
// TODO: Select on long tap or double tap (research diffferent interactions)
// TODO: Add some padding fo volumes (to make sure for square items we don't crop edges)
// TODO: Restora aniamtion after interaction
// TODO: Give some glass background for items mb to be more like cards?

struct PieceWithSpin: View {
    let piece: String
    let pieceDepth: Double
    
    @State private var yaw: Double = 0
    
    var pieceDepthOffset: Double {
        pieceDepth / 2
    }

    // We overlay Model on top of color (plane) because it's easier to center in depth and easy to visually debug
    var body: some View {
        Color.clear
            .overlay(alignment: Alignment.bottom) {
                Model3D(named: piece, bundle: realityKitContentBundle) { model in
                    model
                        .resizable()
                        .scaledToFit()
                        .frame(depth: pieceDepth)
                        .offset(z: -pieceDepthOffset)
                } placeholder: {
                    ProgressView()
                        .frame(depth: pieceDepth)
                        .offset(z: -pieceDepthOffset)
                }
            }
            .rotation3DEffect(.degrees(yaw), axis: .y)
            .animation(.linear(duration: 30).repeatForever(autoreverses: false), value: yaw)
            .onAppear {
                yaw = 360
            }
            .offset(z: pieceDepthOffset)
    }
}

struct PiecePickerView: View {
    @Environment(ViewModel.self) private var model

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: model.pieceSpacing) {
                ForEach(model.selectedLevel!.pieces, id: \.self) { piece in
                    PieceWithSpin(
                        piece: piece,
                        pieceDepth: model.pieceSize
                    )
                        .frame(width: model.pieceSize, height: model.pieceSize)
                        .onTapGesture {
                            print("\(piece) tapped")
                        }
                }
            }
        }
    }
}

#Preview {
    PiecePickerView()
}
