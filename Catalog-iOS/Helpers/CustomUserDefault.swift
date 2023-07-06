//
//  CustomUserDefault.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 06/07/23.
//

import Foundation

enum CustomUserDefaultKey: String {
    case isProductsLoaded = "kIsProductsLoaded"
}

struct CustomUserDefault {
    var key: CustomUserDefaultKey
    
    func setValue(_ value: Any?) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getBool() -> Bool {
        UserDefaults.standard.bool(forKey: key.rawValue)
    }
}
