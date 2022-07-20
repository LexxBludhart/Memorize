//
//  LaunchView.swift
//  Memorize
//
//  Created by Rhett Levitz on 7/20/22.
//

import SwiftUI



struct LaunchView: View {
    
    @State private var showLoadingImage: Bool = false
    @State var showLaunchView: Bool = true
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            if showLoadingImage {
                Image("eggplant")
                    .resizable()
                    .frame(width: 230, height: 230)
                    .transition(AnyTransition.scale.animation(.easeIn(duration: 6.0)))
            }
                
        }
        .onAppear {
            showLoadingImage.toggle()
            AudioManager.instance.playAudio(sound: .dingdong)
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
