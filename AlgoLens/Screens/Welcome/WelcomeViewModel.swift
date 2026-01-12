//
//  WelcomeViewModel.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI
import Combine

@MainActor
final class WelcomeViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var isLogoVisible = false
    @Published var areFeatureItemsVisible = false
    @Published var isButtonVisible = false
    @Published var shouldNavigateToHome = false
    
    // MARK: - Animation Properties
    
    let logoAnimationDuration: Double = 0.8
    let featureItemsAnimationDuration: Double = 0.6
    let buttonAnimationDuration: Double = 0.5
    
    // MARK: - Public Methods
    
    func startAnimations() {
        // Logo animation
        withAnimation(.easeOut(duration: logoAnimationDuration)) {
            isLogoVisible = true
        }
        
        // Feature items animation with delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeOut(duration: self.featureItemsAnimationDuration)) {
                self.areFeatureItemsVisible = true
            }
        }
        
        // Button animation with delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.easeOut(duration: self.buttonAnimationDuration)) {
                self.isButtonVisible = true
            }
        }
    }
    
    func handleStartLearning() {
        shouldNavigateToHome = true
    }
}
