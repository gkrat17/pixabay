//
//  AppDelegate.swift
//  PixaBay
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

import DI
import Domain
import Data
import Presentation
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Domain.configure(repos: .init {
            Dependency { DefaultAuthRepo() as AuthRepo }
            Dependency { DefaultHitRepo() as HitRepo }
        })
        Presentation.configure(usecases: .init {
            Dependency { DefaultAuthUsecase() as AuthUsecase }
            Dependency { DefaultHitUsecase() as HitUsecase }
        })
        Presentation.configure(validators: .init {
            Dependency { DefaultAgeValidator() as AgeValidator }
            Dependency { DefaultEmailValidator() as EmailValidator }
            Dependency { DefaultPasswordValidator() as PasswordValidator }
        })
        return true
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


}

