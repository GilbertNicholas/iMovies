//
//  Utilities.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 16/1/23.
//

import UIKit

class Utilities {
    static func showAlert(title: String, message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: StringPlaceholder.Close.rawValue, style: .default, handler: nil)
        alertController.addAction(action)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func guardUrlNil(url: URL?) -> Any {
        if let url = url {
            return url
        }
        return UIImage(systemName: StringImagePlaceholder.NoImage.rawValue)?.withTintColor(.yellow) ?? UIImage()
    }
    
    static func getInfoPlist(plistKey: String) -> String {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            return ""
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: plistKey) as? String else {
            return ""
        }
        
        return value
    }
}
