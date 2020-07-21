//
//  AppDelegate.swift
//  FirebasePushNotification
//
//  Created by Apple on 26.06.2020.
//  Copyright © 2020 erdogan. All rights reserved.
//

import UIKit
import Firebase //eklendi
import Messages
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self

        FirebaseApp.configure()  //eklendi
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      //print(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }
    
      // Print full message.
      //print(userInfo)
    

      completionHandler(UIBackgroundFetchResult.newData)
    }

    // MARK: UISceneSession Lifecycle

    


}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print message ID.
    /*if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    
    var lastTime: String = ""
    // Print full message.
    if let aps = userInfo["aps"] as? NSDictionary {
        if let alert = aps["alert"] as? NSDictionary {
            if let time = alert["title"] as? String {
               lastTime = time
            }
        }
    }
    let formatterLast = DateFormatter()
    formatterLast.dateFormat = "HH:mm:ss"
    let coreDate = formatterLast.date(from: lastTime)
    
    let currentDateTime = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    let d = formatter.string(from: currentDateTime)
    let phoneDate = formatter.date(from: d)
    
    let diffComponents = Calendar.current.dateComponents([.second], from: coreDate!, to: phoneDate!)
    let seconds = diffComponents.second
    
    //print("saniye farkı: \(String(seconds!))")
    
    let data:[String:String] = ["time": String(seconds!)]

    NotificationCenter.default.post(name: NSNotification.Name("NotificationA"), object: nil, userInfo: data)
    */
    //print(userInfo)
    if let jsonData = userInfo["aps"]{
        var bilgi:String?
        if let temp = userInfo["bilgi"]{
            bilgi = temp as? String
            //print("App delegate bilgi: \(bilgi)")
        }
        
        let data = jsonData as! [String:Any]
        NotificationCenter.default.post(name: .notificationTable, object: bilgi, userInfo: data["alert"] as! [String:Any])
        //print("app delegete if \(data["alert"] as! [String:Any])")
    }
    // Change this to your preferred presentation option
    completionHandler([[.alert, .sound, .badge]])
  }
    
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // Print full message.
    //print(userInfo)

    completionHandler()
  }
}

extension AppDelegate: MessagingDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        InstanceID.instanceID().instanceID(handler: { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        })
    }
}

extension Notification.Name {
    static let notificationTable = Notification.Name(rawValue: "NotificationTable")
}
