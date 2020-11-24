//
//  MatrixView.swift
//  CGV_Task
//
//  Created by Денис Андриевский on 22.11.2020.
//

import UIKit
import Charts

protocol MatrixViewDelegate: class {
    func didPressPrintBtn()
    func didPressBackBtn()
    func didChangeValue(_ newValue: Int)
}

final class MatrixView: UIView {

    // MARK: - IBOutlets
    @IBOutlet private weak var printMatrixBtn: UIButton! {
        didSet {
            printMatrixBtn.setTitle(C.printMatrixTitle, for: .normal)
        }
    }
    @IBOutlet private weak var backBtn: UIButton! {
        didSet {
            backBtn.setTitle(C.backTitle, for: .normal)
        }
    }
    @IBOutlet weak var barChartView: BarChartView!
    // MARK: - Properties
    weak var delegate: MatrixViewDelegate?
    
    // MARK: - IBActions
    @IBAction func printMatrixBtnPressed(_ sender: UIButton) {
        delegate?.didPressPrintBtn()
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        delegate?.didPressBackBtn()
    }
    
    @IBAction func segmentChangedValue(_ sender: UISegmentedControl) {
        delegate?.didChangeValue(sender.selectedSegmentIndex)
    }

}
