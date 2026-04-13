//
//  SplashView.swift
//  TrendingMovies
//
//  Created by Mohannad on 13/04/2026.
//

import Foundation
import SwiftUI
import DesignSystem

struct SplashView: View {
    @Binding var isActive: Bool
    var body: some View {
       contentView
    }
    
    var contentView: some View{
        VStack{
            Spacer()
           
            Text("Trending Movies App")
           .font(DSFonts.title)
           .fontWeight(.bold)
           .multilineTextAlignment(.center)
           .foregroundStyle(DSColors.primary)
           .padding()
           .accessibilityIdentifier("SlugLabel")
            
            Spacer()
            
            ProgressView()
            .tint(DSColors.primary)
           .scaleEffect(2)
           .accessibilityIdentifier("ProgressView")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 40)
        .background(DSColors.background)
        .onAppear(perform: onApear)
    }
    
    func onApear(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                isActive = false
            }
        }
    }
}
