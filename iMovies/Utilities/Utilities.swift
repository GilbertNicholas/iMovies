//
//  Utilities.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 16/1/23.
//

import UIKit

class Utilities {
    class func showAlert(title: String, message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: StringPlaceholder.Close.rawValue, style: .default, handler: nil)
        alertController.addAction(action)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    class func guardUrlNil(url: URL?) -> Any {
        if let url = url {
            return url
        }
        return UIImage(systemName: StringImagePlaceholder.NoImage.rawValue)?.withTintColor(.yellow) ?? UIImage()
    }
}
