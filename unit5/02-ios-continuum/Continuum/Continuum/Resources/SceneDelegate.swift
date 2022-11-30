//
//  SceneDelegate.swift
//  Continuum
//
//  Created by Julia Frederico on 22/11/22.
//

import UIKit
import CloudKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        checkIfAccountStatusIsAvailable { available in
            if !available { print("Account not available") }
        }
    }
    
    // MARK: - Helpers
    
    func checkIfAccountStatusIsAvailable(completion: @escaping (Bool) -> Void) {
        CKContainer.default().accountStatus { status, error in
            let title: String
            
            switch status {
            case .available:
                return completion(true)
            case .noAccount:
                title = "Looks like you don't have an iCloud account. Sign up to use the app."
                self.window?.rootViewController?.presentAlert(title: title, message: nil)
            case .restricted:
                title = "Ops, please check your iCloud account permissions."
                self.window?.rootViewController?.presentAlert(title: title, message: nil)
            case .couldNotDetermine:
                fallthrough
            case .temporarilyUnavailable:
                title = "Ops, there was a problem loging in to your iCloud account. Try again later."
                self.window?.rootViewController?.presentAlert(title: title, message: nil)
            default:
                break
            }
            
            if status != .available {
                completion(false)
            }
        }
    }


}

