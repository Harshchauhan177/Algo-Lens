//
//  CategoryCardView.swift
//  AlgoLens
//
//  Created by harsh chauhan on 12/01/26.
//

import SwiftUI

// MARK: - Category Card View

struct CategoryCardView: View {
    
    // MARK: - Properties
    
    let category: AlgorithmCategoryModel
    let index: Int
    let isVisible: Bool
    
    @State private var isPressed: Bool = false
    @State private var hasAppeared: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Icon Container
            iconSection
            
            Spacer()
            
            // Text Content
            textContent
            
            // Action Text
            actionText
        }
        .padding(20)
        .frame(height: 200)
        .background(gradientBackground)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: category.gradientColors.first?.opacity(0.3) ?? .clear, radius: 10, x: 0, y: 5)
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .opacity(hasAppeared ? 1 : 0)
        .offset(y: hasAppeared ? 0 : 30)
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isPressed)
        .onChange(of: isVisible) { _, newValue in
            if newValue {
                let delay = Double(index) * 0.05
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        hasAppeared = true
                    }
                }
            }
        }
        .onAppear {
            if isVisible {
                let delay = Double(index) * 0.05
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        hasAppeared = true
                    }
                }
            }
        }
    }
    
    // MARK: - View Components
    
    private var iconSection: some View {
        Image(systemName: category.iconName)
            .font(.system(size: 32, weight: .semibold))
            .foregroundColor(.white)
            .frame(width: 60, height: 60)
            .background(Color.white.opacity(0.25))
            .clipShape(Circle())
    }
    
    private var textContent: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(category.title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .lineLimit(2)
            
            Text(category.description)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.white.opacity(0.85))
                .lineLimit(2)
        }
    }
    
    private var actionText: some View {
        HStack {
            Text("Explore")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
            
            Image(systemName: "arrow.right")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
        }
    }
    
    private var gradientBackground: some View {
        LinearGradient(
            gradient: Gradient(colors: category.gradientColors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Pressable Modifier

extension View {
    func pressableScale(isPressed: Binding<Bool>) -> some View {
        self.modifier(PressableScaleModifier(isPressed: isPressed))
    }
}

struct PressableScaleModifier: ViewModifier {
    @Binding var isPressed: Bool
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        isPressed = true
                    }
                    .onEnded { _ in
                        isPressed = false
                    }
            )
    }
}

// MARK: - Preview

#Preview {
    CategoryCardView(
        category: AlgorithmCategoryModel.allCategories[0],
        index: 0,
        isVisible: true
    )
    .padding()
}
