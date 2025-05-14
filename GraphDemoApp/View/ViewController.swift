//
//  ViewController.swift
//  SampleGraphApp
//
//  Created by Tuba N. Yıldız on 13.05.2025.
//

import UIKit
import GraphDemoKit

final class ViewController: UIViewController {
    
    let viewModel = GraphViewModel()
    
    let picker = UIPickerView()
    let segmented = UISegmentedControl()
    let findButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("En Yakın Noktayı Bul", for: .normal)
        return button
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        picker.dataSource = self
        picker.delegate = self
        
        setupSegmentedControl()
        
        findButton.addTarget(self, action: #selector(findNearestTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [picker, segmented, findButton, resultLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupSegmentedControl() {
        let types = viewModel.getPointTypes()
        DispatchQueue.main.async {
            self.segmented.removeAllSegments()
            for (index, type) in types.enumerated() {
                self.segmented.insertSegment(withTitle: type, at: index, animated: false)
            }
            self.segmented.selectedSegmentIndex = 0
            self.viewModel.updateSelectedPointType(to: types.first ?? "")
        }
        segmented.addTarget(self, action: #selector(pointTypeChanged), for: .valueChanged)
    }
    
    private func setupBindings() {
        viewModel.resultText = { [weak self] text in
            DispatchQueue.main.async {
                self?.resultLabel.text = text
            }
        }
    }
    
    @objc func pointTypeChanged() {
        let type = segmented.titleForSegment(at: segmented.selectedSegmentIndex) ?? "wc"
        viewModel.updateSelectedPointType(to: type)
    }
    
    @objc func findNearestTapped() {
        viewModel.findNearestNode()
    }
}


// MARK: - UIPickerView
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.nodeIDs.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.nodeIDs[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.updateSelectedNode(id: viewModel.nodeIDs[row])
    }
}
