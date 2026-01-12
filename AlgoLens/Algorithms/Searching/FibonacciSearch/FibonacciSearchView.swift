//
//  FibonacciSearchView.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI

struct FibonacciSearchView: View {
    @StateObject private var viewModel = FibonacciSearchViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.4, green: 0.8, blue: 0.9),
                    Color(red: 0.3, green: 0.6, blue: 0.7)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("Fibonacci Search")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    Text("Uses Fibonacci numbers for division")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    placeholderSection
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var placeholderSection: some View {
        VStack(spacing: 16) {
            Image(systemName: "function")
                .font(.system(size: 80))
                .foregroundColor(.white.opacity(0.5))
            
            Text("Visualization Coming Soon")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            
            Text("Interactive visualization for Fibonacci Search will be available in the next update")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
        .background(Color.white.opacity(0.15))
        .cornerRadius(20)
    }
}

#Preview {
    NavigationStack {
        FibonacciSearchView()
    }
}
