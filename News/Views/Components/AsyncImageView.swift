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
                    ProgressView()
                case .success(let image) :
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .cornerRadius(5)
                        .clipped()
                case .failure :
                    Image(systemName: "questionmark")
                        .font(.headline)
                    
                @unknown default:
                    fatalError()
                }
                
            }
        } else {
            Rectangle()
                .fill(DefaultTheme.backgroundSecondary)
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(5)
            
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(urlString: MockService.shared.article.urlToImage!)
    }
}
