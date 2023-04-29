//
//  NewsListRowView.swift
//  News
//
//  Created by Oleksii Leshchenko on 29.04.2023.
//

import SwiftUI

struct NewsListRowView: View {
    var body: some View {
        HStack(alignment: .top) {
            
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 60, height: 60)
                .overlay {
                    Text("Image here").foregroundColor(.white)
                }
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text("\("CATEGORY")")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 4)
                        .background(DefaultTheme.tintColor.opacity(0.3))
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 5)
                        )
                    Text("04\\20\\2023")
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                        .font(.caption)
                       
                }
                
                Text("Article Title here")
                    .font(.title3)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                
            
            }
            .padding(.horizontal, 5)
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
                    .font(.title3)
                    .frame(width: 40, height: 40)
                    .rotationEffect(.degrees(90))
            }
        }
    }
}

struct NewsListRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListRowView()
    }
}
