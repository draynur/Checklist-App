//
//  Checklist_AppApp.swift
//  Checklist App
//
//  Created by Runyard, John on 5/7/21.
//

import SwiftUI
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

//import UIKit
//import SwiftUI
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//    var window: UIWindow?
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        let authState = AuthenticationState.shared
//        let contentView = ContentView()
//            .environmentObject(authState)
//
//
//
//        // ...
//    }
//
//    // ...
//}

@main
struct Checklist_AppApp: App {
//    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let viewModel = ContentViewModel()
            ContentView().environmentObject(viewModel)
        }
//        .onChange(of: scenePhase) { (newScenePhase) in
//            ContentView().authState()
//        }
    }
}
