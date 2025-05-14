//
//  GraphViewModel.swift
//  SampleGraphApp
//
//  Created by Tuba N. Yıldız on 13.05.2025.
//

import Foundation
import GraphDemoKit

final class GraphViewModel: ObservableObject {
    
    private var graph: Graph?
    private(set) var nodeIDs: [String] = []
    private(set) var pointTypes: [String] = []
    
    var selectedNodeID: String?
    var selectedPointType: String = "wc"
    
    // Result Output
    var resultText: ((String) -> Void)?
    
    init() {
        loadGraph()
    }
    
    private func loadGraph() {
        guard let url = Bundle.main.url(forResource: "graph", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let nodeDataList = try? JSONDecoder().decode([NodeData].self, from: data) else {
            resultText?("Graph verisi yüklenemedi.")
            return
        }
        
        graph = Graph(from: nodeDataList)
        guard let graph = graph else {
            resultText?("Graph verisi yüklenemedi.")
            return
        }
        nodeIDs = graph.nodes.keys.sorted()
        selectedNodeID = nodeIDs.first
        
        let types = Set(nodeDataList.map { $0.pointType })
            .filter { $0 != "point"}
            .sorted()
        self.pointTypes = types
        self.selectedPointType = types.first ?? "wc"
    }
    
    func getPointTypes() -> [String] {
        self.pointTypes
    }
    
    func updateSelectedPointType(to type: String) {
        self.selectedPointType = type
    }
    
    func updateSelectedNode(id: String) {
        self.selectedNodeID = id
    }
    
    func findNearestNode() {
        guard let graph = graph,
              let startID = selectedNodeID else {
            resultText?("Başlangıç noktası eksik.")
            return
        }
        
        if let result = graph.findNearestNode(from: startID, with: selectedPointType) {
            resultText?("""
            En yakın \(selectedPointType):
            ID: \(result.node.id)
            Mesafe: \(result.distance)
            """)
        } else {
            resultText?("Uygun \(selectedPointType) bulunamadı.")
        }
    }
}
