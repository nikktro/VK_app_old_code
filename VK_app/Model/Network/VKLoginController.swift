//
//  VKLoginController.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 10/02/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import UIKit
import WebKit

class VKLoginController: UIViewController {
  
  @IBOutlet weak var webView: WKWebView! {
    didSet {
      webView.navigationDelegate = self
    }
  }
  
//  //clear Cookies
//  override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(true)
//    webView.cleanAllCookies()
//    webView.refreshCookies()
//  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // VK.com OAUTH
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "oauth.vk.com"
    urlComponents.path = "/authorize"
    urlComponents.queryItems = [
      URLQueryItem(name: "client_id", value: "6853944"),
      URLQueryItem(name: "display", value: "mobile"),
      URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
      URLQueryItem(name: "scope", value: "270342"),
      URLQueryItem(name: "response_type", value: "token"),
      URLQueryItem(name: "v", value: "5.92")
    ]
    
    if let url = urlComponents.url {
      let request = URLRequest(url: url)
      webView.load(request)
    }

  }
}

extension VKLoginController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
    
    guard let url = navigationResponse.response.url,
      url.path == "/blank.html",
      let fragment = url.fragment
      else {
        decisionHandler(.allow)
        return
    }
    
    let params = fragment
      .components(separatedBy: "&")
      .map { $0.components(separatedBy: "=") }
      .reduce([String: String]()) { result, param in
        var dict = result
        let key = param[0]
        let value = param[1]
        dict[key] = value
        return dict
    }
    
    guard let token = params["access_token"], let userId = Int(params["user_id"]!) else {
      decisionHandler(.cancel)
      return
    }
    
    Session.shared.token = token
    Session.shared.userId = userId
    decisionHandler(.cancel)
    performSegue(withIdentifier: "VKLogin", sender: nil)
  
  }
}

extension WKWebView {
  
  func cleanAllCookies() {
    HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
    print("All cookies deleted")
    
    WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
      records.forEach { record in
        WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
        print("Cookie ::: \(record) deleted")
      }
    }
  }
  
  func refreshCookies() {
    self.configuration.processPool = WKProcessPool()
  }
}
