//
//  AsyncImageView.swift
//  News
//
//  Created by Oleksii Leshchenko on 01.05.2023.
//

import SwiftUI
#warning("check CachedAsyncImage memory usage")
struct AsyncImageView: View {
    let urlString: String
    
    var body: some View {
        if let url = URL(string: urlString) {
            CachedAsyncImage(url: url, urlCache: .imageCache) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(DefaultTheme.backgroundSecondary)
        
                        ProgressView()
                            .progressViewStyle(.automatic)
                            .scaleEffect(1.5, anchor: .center)
                            .tint(DefaultTheme.tintColor)
                    }
                case .success(let image) :
                    image.resizable()
                        .scaledToFill()
                        .clipped()
                case .failure :
                    Image(systemName: "photo.fill")
                        .resizable()
                        .foregroundColor(DefaultTheme.tintColor.opacity(0.5))
                        .clipped()

                @unknown default:
                    fatalError()
                }
            }
        } else {
            Image(systemName: "photo.fill")
                .resizable()
                .foregroundColor(DefaultTheme.tintColor.opacity(0.5))
                .clipped()
        }
    }
}

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 100*1000*1000, diskCapacity: 500*1000*1000)
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(urlString: MockService.shared.article.urlToImage!)
    }
}
