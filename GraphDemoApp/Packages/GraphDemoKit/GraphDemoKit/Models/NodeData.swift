//
//  NodeData.swift
//  GraphKit
//
//  Created by Tuba N. Yıldız on 12.05.2025.
//

import Foundation

public struct NodeData: Decodable {
    public let pointType: String
    let id: String
    let edges: [EdgeData]
}
