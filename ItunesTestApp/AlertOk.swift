//
//  AlertOk.swift
//  ItunesTestApp
//
//  Created by Николай Петров on 15.04.2022.
//

import UIKit

extension UIViewController {
    func alertOk(titel: String, message: String) {
        let alert = UIAlertController(title: titel,
                                      message: message,
                                      preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
