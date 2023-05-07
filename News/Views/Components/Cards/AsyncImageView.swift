//
//  AsyncImageView.swift
//  News
//
//  Created by Oleksii Leshchenko on 01.05.2023.
//

import SwiftUI

struct AsyncImageView: View {
    let urlString: String
    
    var body: some View {
        if let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
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
                    Image("placeholder")
                        .scaledToFit()
                        .clipped()

                @unknown default:
                    fatalError()
                }
            }
        } else {
            Rectangle()
                .fill(DefaultTheme.backgroundSecondary)
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(urlString: MockService.shared.article.urlToImage!)
    }
}
