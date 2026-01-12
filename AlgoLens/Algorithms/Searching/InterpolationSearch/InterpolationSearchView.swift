//
//  InterpolationSearchView.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI

struct InterpolationSearchView: View {
    @StateObject private var viewModel = InterpolationSearchViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.8, blue: 0.4),
                    Color(red: 0.9, green: 0.6, blue: 0.3)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("Interpolation Search")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    Text("Uses value estimation for uniformly distributed data")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    // Placeholder for visualization
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
            Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.white.opacity(0.5))
            
            Text("Visualization Coming Soon")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            
            Text("Interactive visualization for Interpolation Search will be available in the next update")
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
        InterpolationSearchView()
    }
}
