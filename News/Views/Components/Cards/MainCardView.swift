//
//  MainCardView.swift
//  News
//
//  Created by Oleksii Leshchenko on 07.05.2023.
//

import SwiftUI

struct MainCardView: View {
    let article: ArticleViewModel
    @EnvironmentObject var realm: RealmService
    @State private var unfoldArticle: Bool = false
    @State private var eyeAnimation: Bool = false
    @AppStorage("theme") var appTheme: Themes = .main
    @Namespace var namespace
    
    var body: some View {
       foldArticleView
            .onDisappear {
                unfoldArticle = false
            }
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
                
                
                VStack(spacing: 10) {
                    articleTitle
                        .overlay(alignment: .topTrailing) {
                            VStack(spacing: 0) {
                                bookmarkButton
                                
                                eyeButton
                                    .matchedGeometryEffect(id: "eye", in: namespace)
                            }
                            .padding(.top, -130)
                            
                        }
                        .matchedGeometryEffect(id: "title", in: namespace)
                    if unfoldArticle {
                        articleDescription
                            .matchedGeometryEffect(id: "desc", in: namespace)
                        NavigationLink(value: article) {
                            articleContent
                                .matchedGeometryEffect(id: "cont", in: namespace)
                        }
                    }
                }
                .navigationDestination(for: ArticleViewModel.self, destination: { article in
                        ArticleWebView(urlString: article.url)
                })
                .background(appTheme.backgroundPrimary)
            }
            .cornerRadius(10)
            .overlay {
                thinBorderOverlay
                
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Main Card View Components
    private var articleTitle: some View {
        Text(article.title)
            .font(.title)
            .fontWeight(.bold)
            .lineLimit(unfoldArticle ? 10 : 2)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .padding(.bottom, 5)
            .padding(.horizontal, 5)
            .background(appTheme.backgroundPrimary)
//            .background(Color.blue)
    }
    
    private var articleDescription: some View {
        Text(article.description ?? "")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(appTheme.fontSecondary)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 3)
            .background(appTheme.backgroundPrimary)
    }
    
    private var articleContent: some View {
        Text(article.content ?? "")
            .font(.title3)
            .fontWeight(.medium)
            .lineSpacing(8)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 3)
            .background(appTheme.backgroundPrimary)
    }
    
    private var thinBorderOverlay: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2)
            .foregroundColor(appTheme.backgroundSecondary)
            .shadow(color: appTheme.backgroundSecondary, radius: 4, x: 0, y: 4)
    }
    
    private var eyeButton: some View {
        Button {
            withAnimation(.easeOut) {
                unfoldArticle.toggle()
            }
        } label: {
            Image(systemName: "eye.fill")
                .font(.title2)
                .foregroundColor(appTheme.tintColor)
                .scaleEffect(eyeAnimation ? 1.2 : 0.7)
                .padding(2)
                .padding(.vertical, 4)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding(10)
        }
    }
    
    private var bookmarkButton: some View {
        Button {
            withAnimation {
                if !realm.objectExist(article: article) {
                    realm.add(article)
                } else {
                    realm.remove(article)
                }
            }
        } label: {
          Image(systemName: realm.objectExist(article: article) ? "bookmark.fill" : "bookmark")
                .font(.title2)
                .foregroundColor(appTheme.tintColor)
                .scaleEffect(eyeAnimation ? 1.2 : 0.7)
                .frame(width: 40)
                
                .padding(.vertical, 4)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding(10)
        }
    }
}

struct MainCardView_Previews: PreviewProvider {
    static var previews: some View {
        MainCardView(article: ArticleViewModel(MockService.shared.articlesUSA[1])!)
            .environmentObject(RealmService(name: "preview"))
    }
}
