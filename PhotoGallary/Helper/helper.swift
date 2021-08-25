//
//  helper.swift
//  PhotoGallary
//
//  Created by Rushang Patel (iOS Developer) on 25/08/21.
//

import Foundation
func ShowAlertError(withTitle: String = "Alert", withMessage: String)
{
    let alert = UIAlertController.init(title: withTitle, message: withMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    DispatchQueue.main.async {
        appDel.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}

func GetDelegateScane() -> SceneDelegate?
{
    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    return windowScene?.delegate as? SceneDelegate
}
