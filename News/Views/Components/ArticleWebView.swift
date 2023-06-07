//
//  ArticleWebView.swift
//  MyAppleNews
//
//  Created by Oleksii Leshchenko on 28.03.2023.
//

import WebKit
import SwiftUI

//@MainActor
struct ArticleWebView: UIViewRepresentable {
    let url: URL?
    init(urlString: String) {
        self.url = URL(string: urlString)
    }

    func makeUIView(context: Context) -> WKWebView {
        // allow use javaScript
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = preferences
    
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = url else { return }
        webView.load(URLRequest(url: url))
    }

}
//
//struct ArticleWebView_Previews: PreviewProvider {
//    static var previews: some View {
////        ArticleWebView(urlString: MockService.shared.article.url)
//    }
//}
