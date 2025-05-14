//
//  EdgeData.swift
//  GraphKit
//
//  Created by Tuba N. Yıldız on 12.05.2025.
//

import Foundation

struct EdgeData: Decodable {
    let id: String         // Hedef node ID'si
    let weight: Double     // Bağlantı ağırlığı
}
