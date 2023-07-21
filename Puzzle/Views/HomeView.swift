//
//  ContentView.swift
//  Puzzle
//
//  Created by Vladyslav Arkavenko on 12/07/2023.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct HomeView: View {
    @Environment(ViewModel.self) private var model
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    var body: some View {
        @Bindable var model = model
        
        if model.selectedLevel != nil {
            EmptyView()
        } else {
            NavigationSplitView {
                List(Level.allCases) { level in
                    NavigationLink(level.name, value: level)
                }
                .navigationDestination(for: Level.self) { level in
                    VStack {
                        Image(uiImage: UIImage(named: level.thumbName)!)
                            .resizable()
                            .aspectRatio(1/1, contentMode: .fit)
                        
                        Button("Open level") {
                            Task {
                                model.selectedLevel = level
                                openWindow(id: "pieacePicker")
                                await openImmersiveSpace(id: "level")
                            }
                        }
                    }
                    .navigationTitle(level.name)
                    .padding(30)
                }
                .navigationTitle("Levels")
            } detail: {
                Text("Select level")
                    .navigationTitle("Level preview")
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(ViewModel())
}
