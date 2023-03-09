//
//  String+.swift
//


import Foundation

public extension String {
    func localized(bundle: Bundle) -> String {
        if let path = bundle.path(forResource: MKLocalize.shared.currentLanguage(), ofType: "lproj"),
           let module = Bundle(path: path) {
            return module.localizedString(forKey: self, value: nil, table: nil)
        }
        
        return NSLocalizedString(self, bundle: Bundle.main, comment: "")
    }
    
}
