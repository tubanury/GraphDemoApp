//
//  GraphNode.swift
//  GraphKit
//
//  Created by Tuba N. Yıldız on 12.05.2025.
//

import Foundation

public class GraphNode {
    public let id: String
    let pointType: String
    var edges: [GraphEdge] = []

    init(id: String, pointType: String) {
        self.id = id
        self.pointType = pointType
    }
}
