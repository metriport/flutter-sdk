//
//  WebViewFactory.swift
//  metriport_flutter
//
//  Created by Jorge orta on 7/18/23.
//

import Foundation
import Flutter
import UIKit

class WebViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FlutterWebView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

     public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
      return FlutterStandardMessageCodec.sharedInstance()
    }
}
