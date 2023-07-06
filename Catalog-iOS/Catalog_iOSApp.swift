//
//  Catalog_iOSApp.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 05/07/23.
//

import SwiftUI

@main
struct Catalog_iOSApp: App {
    init() {
        let userDefault = CustomUserDefault(key: .isProductsLoaded)
        if !userDefault.getBool() {
            let persistanceController = PersistenceController(modelName: "Model")
            FileService().loadProductFromFile(moc: persistanceController.viewContext) { error in
                guard error == nil else { return }
                userDefault.setValue(true)
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(controller: Injection().provideListController())
        }
    }
}
