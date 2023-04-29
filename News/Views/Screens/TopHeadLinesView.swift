//
//  TopHeadLinesView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct TopHeadLinesView: View {
    @State private var selectedIndex: Int = 0
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 250)
                    .padding(.horizontal)
                    .overlay {
                        Text("Recent")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                
                
                CategoryListRoulette()
                
                HStack {
                    Text("See more")
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(DefaultTheme.tintColor)
                        .fontWeight(.semibold)
                        .padding(.trailing, 20)
                }
                
                List {
                    ForEach(0..<10, id: \.self) { index in
                           NewsListRowView()
                            .onTapGesture {
                                selectedIndex = index
                            }
                            .listRowBackground(selectedIndex == index ? Color.secondary.opacity(0.3) : DefaultTheme.backgroundPrimary)
                    }
                    .listRowSeparator(.visible)
                }
                .scrollIndicators(.hidden)
                .listStyle(.inset)
                
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
