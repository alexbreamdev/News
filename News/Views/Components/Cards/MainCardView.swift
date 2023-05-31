//
//  MainCardView.swift
//  News
//
//  Created by Oleksii Leshchenko on 07.05.2023.
//

import SwiftUI

struct MainCardView: View {
    let article: ArticleViewModel
    @State private var eyeAnimation: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImageView(urlString: article.urlToImage)
                .frame(width: UIScreen.main.bounds.width - 20, height: 250)
                .clipped()
                .cornerRadius(10)
                .overlay(alignment: .topTrailing) {
                    eyeButton
                }
                .onChange(of: article) { _ in
                    withAnimation(.spring(response: 0.5)) {
                        eyeAnimation = true
                    }
                    eyeAnimation = false
                }
            
                articleTitle
        }
        .overlay {
            thinBorderOverlay
        }
        .padding(.horizontal)
        
    }
    
    // MARK: - Main Card View Components
    private var articleTitle: some View {
        Text(article.title)
            .font(.title2)
            .fontWeight(.bold)
            .lineLimit(2)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.leading)
            .padding(5)
            .padding(.horizontal, 3)
            .background(DefaultTheme.backgroundPrimary)
    }
    
    private var thinBorderOverlay: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2)
            .foregroundColor(DefaultTheme.backgroundSecondary)
            .shadow(color: DefaultTheme.backgroundSecondary, radius: 4, x: 0, y: 4)
            
    }
    
    private var eyeButton: some View {
        Button {
            
        } label: {
            Image(systemName: "eye.fill")
                .font(.title2)
                .foregroundColor(DefaultTheme.tintColor)
                .padding(10)
                .scaleEffect(eyeAnimation ? 1.2 : 0.7)
                
        }
    }
}

struct MainCardView_Previews: PreviewProvider {
    static var previews: some View {
        MainCardView(article: ArticleViewModel(MockService.shared.articlesUSA[1])!)
    }
}
