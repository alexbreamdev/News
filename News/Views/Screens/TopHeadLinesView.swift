//
//  TopHeadLinesView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct TopHeadLinesView: View {
    @EnvironmentObject var topHeadlinesViewModel: TopHeadlinesViewModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                HStack {
                    Text("See more")
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(DefaultTheme.tintColor)
                        .fontWeight(.semibold)
                        .padding(.trailing, 20)
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 250)
                    .padding(.horizontal)
                    .overlay {
                        Text("Recent")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                
                
                CategoryListRoulette()
                
                NewsListView()
                
            }
        }
        .tabItem {
            Image(systemName: "flame")
            Text("Top Headlines")
                .multilineTextAlignment(.center)
        }
    }
}

struct TopHeadLinesView_Previews: PreviewProvider {
    static var previews: some View {
        TopHeadLinesView()
            .environmentObject(TopHeadlinesViewModel())
    }
}
