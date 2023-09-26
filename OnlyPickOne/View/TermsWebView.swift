//
//  TermsWebView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/26.
// refernce : https://seons-dev.tistory.com/entry/SwiftUI-WebView-%EC%83%9D%EC%84%B1%EC%BD%94%EB%93%9C

import SwiftUI
import WebKit
 
struct TermsWebView: UIViewRepresentable {
    var urlToLoad: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        let webView = WKWebView()
        
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<TermsWebView>) {
        
    }
}
 
struct TermsWebView_Previews: PreviewProvider {
    static var previews: some View {
        TermsWebView(urlToLoad: "https://www.naver.com")
    }
}
