//
//  WelcomeView.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI

struct WelcomeView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = WelcomeViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient
                backgroundGradient
                
                // Main Content
                VStack(spacing: 40) {
                    Spacer()
                    
                    // Logo Section
                    logoSection
                    
                    // Title Section
                    titleSection
                    
                    Spacer()
                    
                    // Features Section
                    featuresSection
                    
                    Spacer()
                    
                    // Start Button
                    startButton
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 60)
            }
            .ignoresSafeArea()
            .onAppear {
                viewModel.startAnimations()
            }
            .navigationDestination(isPresented: $viewModel.shouldNavigateToHome) {
                HomeView()
            }
        }
    }
    
    // MARK: - View Components
    
    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.2, green: 0.4, blue: 0.9),
                Color(red: 0.5, green: 0.3, blue: 0.8)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private var logoSection: some View {
        Image(systemName: "chart.bar.doc.horizontal")
            .font(.system(size: 100))
            .foregroundColor(.white)
            .opacity(viewModel.isLogoVisible ? 1 : 0)
            .scaleEffect(viewModel.isLogoVisible ? 1 : 0.5)
    }
    
    private var titleSection: some View {
        VStack(spacing: 12) {
            Text("AlgoLens")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text("Visualize • Learn • Master Algorithms")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
        }
        .opacity(viewModel.isLogoVisible ? 1 : 0)
    }
    
    private var featuresSection: some View {
        VStack(spacing: 20) {
            FeatureRow(
                icon: "cube.fill",
                title: "Data Structures",
                isVisible: viewModel.areFeatureItemsVisible,
                delay: 0
            )
            
            FeatureRow(
                icon: "function",
                title: "Algorithms",
                isVisible: viewModel.areFeatureItemsVisible,
                delay: 0.1
            )
            
            FeatureRow(
                icon: "eye.fill",
                title: "Step-by-step Visualizations",
                isVisible: viewModel.areFeatureItemsVisible,
                delay: 0.2
            )
        }
    }
    
    private var startButton: some View {
        Button(action: {
            viewModel.handleStartLearning()
        }) {
            Text("Start Learning")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color(red: 0.3, green: 0.4, blue: 0.85))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
        }
        .opacity(viewModel.isButtonVisible ? 1 : 0)
        .scaleEffect(viewModel.isButtonVisible ? 1 : 0.8)
    }
}

// MARK: - Feature Row Component

struct FeatureRow: View {
    let icon: String
    let title: String
    let isVisible: Bool
    let delay: Double
    
    @State private var isAnimated = false
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
            
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.white.opacity(0.15))
        .cornerRadius(14)
        .offset(x: isAnimated ? 0 : -50)
        .opacity(isAnimated ? 1 : 0)
        .onChange(of: isVisible) { _, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                        isAnimated = true
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    WelcomeView()
}
