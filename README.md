# GraphKit

GraphKit is a reusable iOS framework written in Swift that allows parsing a graph from a JSON dataset and finding the nearest special node (based on `pointType`) from any given node. A sample app is included to demonstrate the usage of the framework.

---
## 🚀 Features

* ✅ Parses graph data from JSON
* ✅ Identifies and categorizes nodes by `pointType`
* ✅ Finds nearest node with a given `pointType` using Dijkstra's algorithm
* ✅ Provides a modular framework structure (can be reused in other apps)
* ✅ Includes sample app with basic MVVM structure
* ✅ Dynamic UI based on available point types

---

## 📄 JSON Format

Each node in the graph is represented as:

```json
{
  "id": "node-id",
  "pointType": "wc",
  "edges": [
    { "id": "connected-node-id", "weight": 7.5 },
    { "id": "another-node-id", "weight": 3.0 }
  ]
}
```

---

## 📦 How to Build and Run

### 1. Clone the Repository

```bash
git clone https://github.com/tubanury/GraphDemoApp.git
```

### 2. Open in Xcode

Open `GraphDemoApp.xcodeproj` or `GraphDemoApp.xcworkspace` (if using Swift Package Manager or CocoaPods).

### 3. Build & Run

* Choose the `GraphDemoApp` target
* Press ⌘R to run

---

## 🛠 Architecture

### Framework: `GraphDemoKit`

* `Graph.swift`: Contains graph representation and shortest-path algorithm
* `NodeData.swift`: Codable model for parsing JSON nodes

### Sample App: `GraphDemoApp`

* MVVM pattern
* ViewModel: Handles loading graph and exposing UI-friendly data
* SegmentedControl and Picker are dynamically populated based on graph data

---

## 🔍 Framework Usage Example

```swift
let graph = Graph(from: graphData)
let result = graph.findNearestNode(from: "start-node-id", with: "wc")
print(result?.node.id, result?.distance)
```

---

## 📌 Design Decisions

* **Modularity:** GraphKit is isolated from app-specific logic for reusability.
* **Dijkstra’s Algorithm:** Chosen for guaranteed shortest path in weighted graphs.
* **Dynamic UI:** UI controls are driven by data, not hardcoded values.
* **MVVM:** Separates UI logic from business logic for better testability and maintainability.

---

## ✅ To-Do / Possible Improvements

* [ ] Add unit tests for path-finding logic
* [ ] Visualize the path between nodes in the UI
* [ ] Support bidirectional edges
* [ ] Add error handling for malformed JSON

---

## 📄 License

MIT License – use freely with attribution.

---

## 🙋‍♂️ Questions?

Feel free to reach out via GitHub Issues or pull requests. Thanks for reviewing the project!
