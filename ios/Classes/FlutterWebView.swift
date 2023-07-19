import Foundation
import Flutter
import UIKit
import MetriportSDK
import SwiftUI

 struct Arguments {
    var clientApiKey: String
    var token: String
    var sandbox: Bool
    var  colorMode: String?
    var  customColor: String?
    var  providers: [String]?
    var  url: String?
    var  apiUrl: String?
 }

class FlutterWebView: NSObject, FlutterPlatformView {
    private var _nativeWebView: UIWebView
    private var _methodChannel: FlutterMethodChannel
    let webview: MetriportWidgetView

    func view() -> UIView {
        return self.webview
    }

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {

        var metriportArgs = args as? [String: Any]

        _nativeWebView = UIWebView()
        _methodChannel = FlutterMethodChannel(name: "plugins.metriport_flutter/flutter_web_view_\(viewId)", binaryMessenger: messenger)

        let webview = MetriportWidgetView()
        webview.clientApiKey = metriportArgs?["clientApiKey"] as? String ?? ""
        webview.token = metriportArgs?["token"] as? String ?? ""
        webview.sandbox = metriportArgs?["sandbox"] as? Bool ?? false
        webview.colorMode = metriportArgs?["colorMode"] as? String
        webview.customColor = metriportArgs?["customColor"] as? String
        webview.providers = metriportArgs?["providers"] as? [String]
        webview.url = metriportArgs?["url"] as? String
        webview.apiUrl = metriportArgs?["apiUrl"] as? String

        self.webview = webview

        super.init()
        // iOS views can be created here
        _methodChannel.setMethodCallHandler(onMethodCall)

    }


    func onMethodCall(call: FlutterMethodCall, result: FlutterResult) {
        switch(call.method){
        case "setUrl":
            setText(call:call, result:result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    func setText(call: FlutterMethodCall, result: FlutterResult){
        let url = call.arguments as! String
        _nativeWebView.loadRequest(NSURLRequest(url: NSURL(string: url)! as URL) as URLRequest)
    }

}

class MetriportWidgetView : UIView {
  private var vc = UIHostingController(rootView: WidgetView())


  @objc var clientApiKey: String = "" {
    didSet {
      vc.rootView.clientApiKey = clientApiKey
    }
  }
  @objc var token: String = "" {
    didSet {
      vc.rootView.token = token
    }
  }
  @objc var sandbox: Bool = false {
    didSet {
      vc.rootView.sandbox = sandbox
    }
  }
  @objc var apiUrl: String? = nil {
    didSet {
      vc.rootView.apiUrl = apiUrl
    }
  }
  @objc var colorMode: String? = nil {
    didSet {
      vc.rootView.colorModeText = colorMode
    }
  }
  @objc var customColor: String? = nil {
    didSet {
      vc.rootView.customColor = customColor
    }
  }
  @objc var providers: [String]? = nil {
    didSet {
      vc.rootView.providers = providers
    }
  }
  @objc var url: String? = nil {
    didSet {
      vc.rootView.url = url
    }
  }


  override init(frame: CGRect) {
    super.init(frame: frame)
    createSubViews()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    createSubViews()
  }

  private func createSubViews() {
    self.addSubview(vc.view)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    vc.view.frame = self.bounds
  }
}

struct WidgetView : View {
    var clientApiKey: String = ""
    var token: String = ""
    var sandbox: Bool = false
    var apiUrl: String? = nil
    var colorModeText: String? = nil
    var customColor: String? = nil
    var providers: [String]? = nil
    var url: String? = nil

    var healthStore: MetriportHealthStoreManager {
      MetriportHealthStoreManager(clientApiKey: clientApiKey, sandbox: sandbox, apiUrl: apiUrl);
    }

    var body: some View {

        VStack {
            MetriportWidget(
              healthStore: healthStore,
              token: token,
              sandbox: sandbox,
              colorMode: colorModeText == "dark" ? ColorMode.dark : ColorMode.light,
              customColor: customColor,
              providers: providers,
              url: url
            )
        }
    }
}
