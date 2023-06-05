//
//  MainCardView.swift
//  News
//
//  Created by Oleksii Leshchenko on 07.05.2023.
//

import SwiftUI

struct MainCardView: View {
    let article: ArticleViewModel
    @State private var unfoldArticle: Bool = false
    @State private var eyeAnimation: Bool = false
    @Namespace var namespace
    
    var body: some View {
        foldArticleView
    }
    
    // MARK: - Fold / Unfold Article
    var foldArticleView: some View {
        ZStack(alignment: .bottom) {
            VStack {
                AsyncImageView(urlString: article.urlToImage)
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 250)
                    .clipped()
                    .matchedGeometryEffect(id: "image", in: namespace)
                    .onChange(of: article) { _ in
                        withAnimation(.spring(response: 0.5)) {
                            eyeAnimation = true
                        }
                        eyeAnimation = false
                    }
                
                
                VStack(spacing: 4) {
                    articleTitle
                        .overlay(alignment: .topTrailing) {
                            eyeButton
                                .matchedGeometryEffect(id: "eye", in: namespace)
                                .padding(.top, -60)
                        }
                        .matchedGeometryEffect(id: "title", in: namespace)
                    if unfoldArticle {
                        articleDescription
                            .matchedGeometryEffect(id: "desc", in: namespace)
                        
                    }
                    
                }
                .background(DefaultTheme.backgroundPrimary)
            }
            .cornerRadius(10)
            .overlay {
                thinBorderOverlay
                
            }
        }
        .padding(.horizontal)
    }
    
    var unfoldArticleView: some View {
        ZStack(alignment: .bottom) {
            VStack {
                AsyncImageView(urlString: article.urlToImage)
                //                                .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 2.4, alignment: .top)
                    .clipped()
                    .cornerRadius(10)
                    .matchedGeometryEffect(id: "image", in: namespace)
                    .onChange(of: article) { _ in
                        withAnimation(.spring(response: 0.5)) {
                            eyeAnimation = true
                        }
                        eyeAnimation = false
                    }
                
                VStack(spacing: 0) {
                    articleTitle
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .overlay(alignment: .topTrailing) {
                            eyeButton
                                .matchedGeometryEffect(id: "eye", in: namespace)
                                .padding(.top, -40)
                        }
                    
                    articleDescription
                        .matchedGeometryEffect(id: "desc", in: namespace)
                }
                .background(DefaultTheme.backgroundPrimary)
            }
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
            .lineLimit(unfoldArticle ? 4 : 2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: unfoldArticle ? 55 : 55, alignment: .top)
            .multilineTextAlignment(.leading)
            .padding(5)
            .padding(.horizontal, 3)
            .background(DefaultTheme.backgroundPrimary)
    }
    
    private var articleDescription: some View {
        Text(article.description ?? "")
            .font(.body)
            .fontWeight(.medium)
            .fixedSize(horizontal: false, vertical: false)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: unfoldArticle ? 70  :  55, alignment: .top)
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
            withAnimation(.easeOut) {
                unfoldArticle.toggle()
            }
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
