//
//  ViewController.swift
//  JavaScriptCoreDemo
//
//  Created by qihaijun on 12/15/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import WebKit
import Cocoa
import Foundation
import JavaScriptCore

@objc protocol TestJSExports: JSExport {
    func functionInSwift(Str: String)
}

class ViewController: NSViewController, WebFrameLoadDelegate, WebUIDelegate, WebResourceLoadDelegate, WebPolicyDelegate, TestJSExports {
    @IBOutlet weak var webView: WebView!
    var jsContext: JSContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSBundle.mainBundle().URLForResource("index", withExtension: "html")!
        webView.mainFrame.loadRequest(NSURLRequest(URL: url))
    }
    
    // MARK: - UIWebViewDelegate
    func webView(sender: WebView!, didFinishLoadForFrame frame: WebFrame!)
    {

        title = webView.stringByEvaluatingJavaScriptFromString("document.title")
        
        // 禁用页面元素选择
        webView.stringByEvaluatingJavaScriptFromString("document.documentElement.style.webkitUserSelect='none';")
        
        // 禁用长按弹出ActionSheet
        webView.stringByEvaluatingJavaScriptFromString("document.documentElement.style.webkitTouchCallout='none';")
        
        jsContext = webView.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as? JSContext
        jsContext?.exceptionHandler = { context, exception in
            context.exception = exception
            print(exception)
        }
        
        // 调用JS方法
        jsContext?.objectForKeyedSubscript("show")?.callWithArguments(["Swift call"])
        
        // 1. JS通过JSExport调用Native方法
        jsContext?.setObject(self, forKeyedSubscript: "native")
        
        // 2. JS通过Block调用Native
        let log: @convention(block) String -> Void = { input in
            print(input)
        }
        jsContext?.setObject(unsafeBitCast(log, AnyObject.self), forKeyedSubscript: "log")
    }
    
    // MARK: - TestJSExports
    func functionInSwift(Str: String) {
        print("Call function in swift: \(Str)")
    }
}