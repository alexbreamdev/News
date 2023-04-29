//
//  ArticleWebView.swift
//  MyAppleNews
//
//  Created by Oleksii Leshchenko on 28.03.2023.
//

import WebKit
import SwiftUI

@MainActor
struct ArticleWebView: UIViewRepresentable {
   
    typealias UIViewType = WKWebView

    let webView: WKWebView
    #warning("add config here")
    init(urlString: String) {
        webView = WKWebView(frame: .zero)
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.load(URLRequest(url: URL(string: urlString)!))
    }

    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }

}
//
//struct ArticleWebView_Previews: PreviewProvider {
//    static var previews: some View {
////        ArticleWebView(urlString: MockService.shared.article.url)
//    }
//}
