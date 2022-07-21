//
//  LaunchView.swift
//  Memorize
//
//  Created by Rhett Levitz on 7/20/22.
//

import SwiftUI



struct LaunchView: View {
    
    @State private var showLoadingImage: Bool = false
    @Binding var showLaunchView: Bool
    var launchImage = Image("eggplant")
    var launchImage2 = Image("eggplant")
    var isAnimated = true
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            if showLoadingImage {
                launchImage
                    .resizable()
                    .frame(width: 375, height: 390)
                    .shadow(color: .white, radius: 50.0, x: 5.0, y: 10.0)
                    .ignoresSafeArea()
                    .transition(AnyTransition.scale.animation(.easeInOut(duration: 6.0).delay(0.25)).combined(with: .opacity.animation(.easeIn(duration: 6.0))))
                
            }
                
        }
        .onAppear {
            showLoadingImage.toggle()
            AudioManager.instance.playAudio(sound: .dingdong)
        }
        .onTapGesture {
            showLaunchView = false
            AudioManager.instance.playAudio(sound: .disappear)
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
