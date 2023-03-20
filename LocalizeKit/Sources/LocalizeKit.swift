//
//  LocalizeKit.swift
//
        

import Foundation

public enum LocalizeKitState {
    case system
    case custom
}

public class LocalizeKit {
    public static let shared = LocalizeKit()
    public var localizingMode: LocalizeKitState = .system
    
    private var currentLanguageKey: String? {
        get {
            return UserDefaults.standard.object(forKey: Constants.LCLCurrentLanguageKey) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.LCLCurrentLanguageKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    private init() {
        
    }
    
    /// Configure Module
    /// - Parameters:
    ///   - localizingMode: system // custom
    ///   - defaultLanguage: when custom localize need default language (it doesn't work after setCurrentLanguage() Called )
    public func configure(
        localizingMode: LocalizeKitState,
        defaultLanguage: String? = nil
    ) {
        self.localizingMode = localizingMode
        switch self.localizingMode {
            case .system:
                self.currentLanguageKey = nil
                
            case .custom:
                break
        }
        
        if let defaultLanguage = defaultLanguage {
            Constants.LCLDefaultLanguage = defaultLanguage
        }
        
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
                if let currentLanguage = self.currentLanguageKey {
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
        self.currentLanguageKey = nil
//        self.setCurrentLanguage(self.defaultLanguage())
    }
    
    public func setCurrentLanguage(_ language: String) {
        let selectedLanguage = availableLanguages().contains(language)
        ? language
        : self.defaultLanguage()
        
        if selectedLanguage != self.currentLanguage() {
            self.currentLanguageKey = selectedLanguage
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

extension LocalizeKit {
    struct Constants {
        static let LCLCurrentLanguageKey = "LCLCurrentLanguageKey"
        static var LCLDefaultLanguage = "ko"
        static let LCLBaseBundle = "Base"
    }
}
