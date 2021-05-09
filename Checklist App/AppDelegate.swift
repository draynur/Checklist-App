//
//  AppDelegate.swift
//  Checklist App
//
//  Created by user931069 on 5/8/21.
//

import Foundation
import UIKit
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

}
