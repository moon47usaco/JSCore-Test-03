# JSCore-Test-03
Testing using JavaScriptCore in a Mac OS X application

Trying to port an iOS example into Mac OS X found at https://github.com/victorchee/JavaScriptCoreDemo

Having trouble with the below statement in ViewController.swift:

jsContext = webView.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as? JSContext

Getting the fallowing exception and no features work.

2016-10-07 18:39:01.664 JSCore-Test-01[17603:689101] *** WebKit discarded an uncaught exception in the webView:didFinishLoadForFrame: 
delegate: <NSUnknownKeyException> [<WebView 0x6080001208c0> valueForUndefinedKey:]: 
this class is not key value coding-compliant for the key documentView

Tried changing documentView.webView.mainFrame.javaScriptContext to webView.mainFrame.javaScriptContext and this removes the exception but buttons still do not trigger JavaScript code.

Question on stackoverflow:
http://stackoverflow.com/questions/39916706/javascriptcore-call-a-native-swift-function-os-x-webview
