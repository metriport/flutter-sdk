import Flutter
import UIKit

public class MetriportFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        registrar.register(WebViewFactory(messenger: registrar.messenger()), withId: "MetriportWebView")
    }
}