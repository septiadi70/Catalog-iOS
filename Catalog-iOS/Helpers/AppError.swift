//
//  AppError.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 06/07/23.
//

import Foundation

enum AppError {
    case saveToCoreDataFailed
    case updateProductFailed
    case fileNotFound
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .saveToCoreDataFailed: return "Save to core data failed"
        case .updateProductFailed: return "Update product failed"
        case .fileNotFound: return "File JSON not found"
        }
    }
}
