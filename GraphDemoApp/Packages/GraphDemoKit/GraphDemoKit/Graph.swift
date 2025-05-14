//
//  Graph.swift
//  GraphKit
//
//  Created by Tuba N. Yıldız on 12.05.2025.
//

import Foundation

public final class Graph {
    public var nodes: [String: GraphNode] = [:]
    
    public init(from data: [NodeData]) {
        buildGraph(from: data)
    }
    
    private func buildGraph(from data: [NodeData]) {
        //Create nodes
        for nodeData in data {
            let node = GraphNode(id: nodeData.id, pointType: nodeData.pointType)
            nodes[node.id] = node
        }
        
        //Match nodes with edges
        for nodeData in data {
            guard let node = nodes[nodeData.id] else { continue }
            for edgeData in nodeData.edges {
                node.edges.append(GraphEdge(id: edgeData.id, weight: edgeData.weight))
            }
        }
    }
    
    func node(withID id: String) -> GraphNode? {
        return nodes[id]
    }
    
    public func findNearestNode(from startID: String, with pointType: String) -> (node: GraphNode, distance: Double)? {
        guard nodes[startID] != nil else { return nil }
        
        var distances: [String: Double] = [:]
        var visited: Set<String> = []
        var queue: [(id: String, distance: Double)] = [(startID, 0)]
        
        //Set initial distance for all nodes
        for id in nodes.keys {
            distances[id] = Double.infinity
        }
        distances[startID] = 0
        
        while !queue.isEmpty {
            queue.sort { $0.distance < $1.distance }
            let (currentID, currentDistance) = queue.removeFirst()
            
            guard !visited.contains(currentID),
                  let currentNode = nodes[currentID] else { continue }
            
            visited.insert(currentID)
            
            for edge in currentNode.edges {
                let neighborID = edge.id
                let newDistance = currentDistance + edge.weight
                
                if newDistance < (distances[neighborID] ?? Double.infinity) {
                    distances[neighborID] = newDistance
                    queue.append((neighborID, newDistance))
                }
            }
        }
        
        //Find closest node with point type matched
        var closest: (node: GraphNode, distance: Double)? = nil
        
        for (id, node) in nodes {
            guard node.pointType == pointType,
                  let dist = distances[id],
                  dist < (closest?.distance ?? Double.infinity) else { continue }
            closest = (node, dist)
        }
        return closest
    }
}
