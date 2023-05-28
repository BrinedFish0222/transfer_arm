//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import screen_retriever
import sqflite
import tray_manager
import url_launcher_macos
import window_manager

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  ScreenRetrieverPlugin.register(with: registry.registrar(forPlugin: "ScreenRetrieverPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
  TrayManagerPlugin.register(with: registry.registrar(forPlugin: "TrayManagerPlugin"))
  UrlLauncherPlugin.register(with: registry.registrar(forPlugin: "UrlLauncherPlugin"))
  WindowManagerPlugin.register(with: registry.registrar(forPlugin: "WindowManagerPlugin"))
}
