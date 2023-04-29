//
//  TopHeadLinesView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct TopHeadLinesView: View {
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 250)
                    .padding(.horizontal)
                    .overlay {
                        Text("Recent")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                
                
                CategoryListRoulette()
                
                List {
                    ForEach(0..<10, id: \.self) {_ in
                            VStack {
                                Text("News title long and large")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Text("Short description")
                            }
                        
                    }
                }
                .listStyle(.inset)
                .padding(.bottom, 50)
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
    }
}
