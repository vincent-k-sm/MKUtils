//
//  MKLocalize.swift
//
        

import Foundation

public enum MKLocalizeState {
    case system
    case custom
}

public class MKLocalize {
    public static let shared = MKLocalize()
    public var localizingMode: MKLocalizeState = .system
    
    private init() {
        
    }
    
    public func configure(
        localizingMode: MKLocalizeState,
        defaultLanguage: String
    ) {
        self.localizingMode = localizingMode
        Constants.LCLDefaultLanguage = defaultLanguage
    }
    
    public func availableLanguages(_ excludeBase: Bool = false) -> [String] {
        var availableLanguages = Bundle.main.localizations
        // If excludeBase = true, don't include "Base" in available languages
        if let indexOfBase = availableLanguages.firstIndex(of: Constants.LCLBaseBundle),
           excludeBase {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }
    
    public func currentLanguage() -> String {
        switch self.localizingMode {
            case .system:
                return defaultLanguage()
                
            case .custom:
                if let currentLanguage = UserDefaults.standard.object(
                    forKey: Constants.LCLCurrentLanguageKey
                ) as? String {
                    return currentLanguage
                }
                return defaultLanguage()
        }
        
    }
    
    public func defaultLanguage() -> String {
        var defaultLanguage: String = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return Constants.LCLDefaultLanguage
        }
        let availableLanguages: [String] = self.availableLanguages()
        if availableLanguages.contains(preferredLanguage) {
            defaultLanguage = preferredLanguage
        }
        else {
            defaultLanguage = Constants.LCLDefaultLanguage
        }
        return defaultLanguage
    }
    
    public func resetCurrentLanguageToDefault() {
        self.setCurrentLanguage(self.defaultLanguage())
    }
    
    public func setCurrentLanguage(_ language: String) {
        let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
        if selectedLanguage != currentLanguage() {
            UserDefaults.standard.set(selectedLanguage, forKey: Constants.LCLCurrentLanguageKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    public func displayNameForLanguage(_ language: String) -> String {
        let locale: NSLocale = NSLocale(localeIdentifier: currentLanguage())
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return language
    }
}



extension MKLocalize {
    struct Constants {
        static let LCLCurrentLanguageKey = "LCLCurrentLanguageKey"
        static var LCLDefaultLanguage = "ko"
        static let LCLBaseBundle = "Base"
    }
}
