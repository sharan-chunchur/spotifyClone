import UIKit
import Flutter
import Foundation
 
 @UIApplicationMain
 @objc class AppDelegate: FlutterAppDelegate {
        
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let mlkitChannel = FlutterMethodChannel(name: "com.dynamicIcon",
                                                  binaryMessenger: controller.binaryMessenger)
    mlkitChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if call.method == "launcherFirst"{
            /* Start */
            if #available(iOS 10.3, *) {
                let iconName = "app_icon_g";
                self.setIcon(iconName)
            }else {
                result("Not supported on iOS ver < 10.3");
                   }
            /* End */
            }else if call.method == "launcherSecond"{
                /* Start */
                if #available(iOS 10.3, *) {
                    let iconName = "app_icon_b";
                    self.setIcon(iconName)
                }else {
                    result("Not supported on iOS ver < 10.3");
                       }
                /* End */
                }else if call.method == "default"{
                        /* Start */
                        if #available(iOS 10.3, *) {
                            let iconName = "app_icon_g";
                            self.setIcon(iconName)
                        }else {
                            result("Not supported on iOS ver < 10.3");
                               }
                        /* End */
                        }
 })
 
 
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func setIcon(_ appIcon: String) {
            if UIApplication.shared.supportsAlternateIcons{
                UIApplication.shared.setAlternateIconName(appIcon) { error in
                    if let error = error {
                        print("Error setting alternate icon \(appIcon): \(error.localizedDescription)")
                    }
                }
            }
        }
        
 }
