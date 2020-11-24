//
//  MatrixVC.swift
//  CGV_Task
//
//  Created by Денис Андриевский on 22.11.2020.
//

import UIKit
import Charts

enum BarType: CaseIterable {
    case red, green, blue, brightness
}

final class MatrixVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var mainView: MatrixView!
    // MARK: - Properties
    private var barType: BarType = .red {
        didSet {
            setupChart()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupChart()
    }
    
    private func setupChart() {
        guard let colorArray = User.shared.pixelColorArray else { return }
        var preparedData: [Int] = []
        switch barType {
        case .red:
            preparedData = colorArray.map { Int($0.red) }
        case .green:
            preparedData = colorArray.map { Int($0.green) }
        case .blue:
            preparedData = colorArray.map { Int($0.blue) }
        case .brightness:
            preparedData = colorArray.map { Int($0.brightness) }
        }
        var preparedDataDictionary: [Int: Int] = [:]
        for value in preparedData {
            if preparedDataDictionary[value] != nil {
                preparedDataDictionary[value]! += 1
            } else {
                preparedDataDictionary[value] = 1
            }
        }
        var dataEntries: [BarChartDataEntry] = []
        let keys = Array(preparedDataDictionary.keys)
        for i in 0..<keys.count {
            let dataEntry = BarChartDataEntry(x: Double(keys[i]), y: Double(preparedDataDictionary[keys[i]]!))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        let chartData = BarChartData(dataSet: chartDataSet)
        mainView.barChartView.data = chartData
    }

}
// MARK: - MatrixViewDelegate
extension MatrixVC: MatrixViewDelegate {
    
    func didPressPrintBtn() {
        guard let userPixels = User.shared.pixelColorArray else { return }
        for pixel in userPixels {
            print(pixel.brightness, terminator: " ")
        }
    }
    
    func didPressBackBtn() {
        dismiss(animated: true, completion: nil)
    }
    
    func didChangeValue(_ newValue: Int) {
        let selectedValue = BarType.allCases[newValue]
        barType = selectedValue
    }
    
}
