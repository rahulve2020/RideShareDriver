//
//  AppDelegate.swift
//  RideShare_FR_User
//
//  Created by Priya Rastogi on 01/07/22.
//

import UIKit
import IQKeyboardManager
import GoogleMaps
import GooglePlaces
import Stripe
import Firebase
import FirebaseMessaging
import UserNotifications


// STPAPIClient.shared().publishableKey = Constants.publishableKeyStripe
@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {

  var window: UIWindow?
    var deviceTokenStr = ""
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared().isEnabled = true
        
      //  window?.overrideUserInterfaceStyle = .light
        Messaging.messaging().isAutoInitEnabled = true
        Messaging.messaging().delegate = self

        GMSServices.provideAPIKey("AIzaSyDOAIDFY9jhsFrZXDynm7-C4D6T_lxe52Y")
        GMSPlacesClient.provideAPIKey("AIzaSyDOAIDFY9jhsFrZXDynm7-C4D6T_lxe52Y")
        STPAPIClient.shared().publishableKey = Constants.publishableKeyStripe
        // Override point for customization after application launch.
        
        // 1
        FirebaseApp.configure()
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            deviceTokenStr = uuid as String
        }
        
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        UNUserNotificationCenter.current().delegate = self
        
        let notificationCenter = UNUserNotificationCenter.current()
           notificationCenter.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
               // Enable or disable features based on authorization.
           }
           notificationCenter.delegate = self
           application.registerForRemoteNotifications()
        if #available(iOS 13.0, *) {
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        application.registerForRemoteNotifications()
        
        if Facade.shared.isLogin == true {
            
            let story = UIStoryboard(name: "Main", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "LocationDemoViewController") as! LocationDemoViewController
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
            
        }

        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        messaging.token { token, _ in
//            guard let token = token else {
//                return
//            }
//            print("Token: \(token)")
//        }
        DSUserPrefrence.device_token = fcmToken ?? ""
        print("Firebase registration token: \(DSUserPrefrence.device_token)")

    }

    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    print("userInfo",userInfo)

    completionHandler(UIBackgroundFetchResult.newData)

}
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
   

      // Print full message.
      print(userInfo)
    }
    
    func scheduleNotifications() {
        print("custom notificaiton")
        let content = UNMutableNotificationContent()
        let requestIdentifier = "abhishek"
        content.badge = 1
        content.title = "This is a rich notification"
        content.subtitle = "Hello there, I am abhishek"
        content.body = "Hello body"
        content.categoryIdentifier = "actionCategory"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("bingbong.caf"))
        print(UNNotificationSoundName("sound.caf"))
        // If you want to attach any image to show in local notification
//        let url = Bundle.main.url(forResource: "notificationImage", withExtension: ".jpg")
//        do {
//            let attachment = try? UNNotificationAttachment(identifier: requestIdentifier, url: url!, options: nil)
//            content.attachments = [attachment!]
//        }

        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 3.0, repeats: false)

        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error:Error?) in

            if error != nil {
                print(error?.localizedDescription ?? "some unknown error")
            }
            print("Notification Register Success")
        }
    }
    
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.hexString
        if deviceTokenString == "" {
            DSUserPrefrence.device_token =  deviceTokenStr
        }
        else{
            DSUserPrefrence.device_token =  deviceTokenString
        }
        print(deviceTokenString)
    }

}
extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}


@available(iOS 13.0, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // ...

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.alert, .sound]])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    let objNotification = Notification.Name("updateDriver")
    NotificationCenter.default.post(name: objNotification, object: nil, userInfo: userInfo)
    print(userInfo)

    completionHandler()
  }
}
