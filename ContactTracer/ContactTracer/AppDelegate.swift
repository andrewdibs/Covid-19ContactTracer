//
//  AppDelegate.swift
//  ContactTracer
//
//  Created by dibs on 9/9/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import UIKit
import BackgroundTasks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerBackgroundTasks()
        // Override point for customization after application launch.
        print("finished launch")
        return true
    }
    
   func registerBackgroundTasks() {
      // Declared at the "Permitted background task scheduler identifiers" in info.plist
      let backgroundAppRefreshTaskSchedulerIdentifier = "get"
     // let backgroundProcessingTaskSchedulerIdentifier = "com.example.fooBackgroundProcessingIdentifier"

      // Use the identifier which represents your needs
      BGTaskScheduler.shared.register(forTaskWithIdentifier: backgroundAppRefreshTaskSchedulerIdentifier, using: nil) { (task) in
         print("BackgroundAppRefreshTaskScheduler is executed NOW!")
         print("Background time remaining: \(UIApplication.shared.backgroundTimeRemaining)s")
         task.expirationHandler = {
           task.setTaskCompleted(success: false)
         }

 //      Do some data fetching and call setTaskCompleted(success:) asap!
         let isFetchingSuccess = true
         task.setTaskCompleted(success: isFetchingSuccess)
       }
     }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("submit tasks")
      submitBackgroundTasks()
    }
    
    func submitBackgroundTasks() {
      // Declared at the "Permitted background task scheduler identifiers" in info.plist
      let backgroundAppRefreshTaskSchedulerIdentifier = "get"
      let timeDelay = 10.0

      do {
        let backgroundAppRefreshTaskRequest = BGAppRefreshTaskRequest(identifier: backgroundAppRefreshTaskSchedulerIdentifier)
        backgroundAppRefreshTaskRequest.earliestBeginDate = Date(timeIntervalSinceNow: timeDelay)
        try BGTaskScheduler.shared.submit(backgroundAppRefreshTaskRequest)
        print("Submitted task request")
      } catch {
        print("Failed to submit BGTask")
      }
    }
    
//    func putCoordinates(){
//
//        print("running background task")
//         let hashnodash = user.hash.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
//        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
//        print("PUT")
//        let parameters: [String: String] = ["hash": "abc", "x": String(coordinate.latitude), "y": String(coordinate.longitude)]
//        //create the url with URL
//        guard let url = URL(string: "http://192.168.1.64:8000/user")else{return} //change the url
//        //create the session object
//        let session = URLSession.shared
//        //now create the URLRequest object using the url object
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT" //set http method as POST
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        //create dataTask using the session object to send data to the server
//        let task = session.dataTask(with: request, completionHandler: { data, response, error in
//            guard error == nil else {
//                return
//            }
//            guard let data = data else {
//                return
//            }
//            do {
//                //create json object from data
//                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                    print(json)
//                    // handle json...
//                }
//
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        })
//        task.resume()
//    }// END PUT

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        print("new scene")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        print("discarded")
    }
    
}

