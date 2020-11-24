//
//  MenuView.swift
//  CGV_Task
//
//  Created by Денис Андриевский on 22.11.2020.
//

import UIKit

protocol MenuViewDelegate: class {
    func matrixBtnPressed()
    func binarizationBtnPressed(with image: UIImage?)
    func grayBtnPressed(with image: UIImage?)
    func normalBtnPressed(with image: UIImage?)
    func kirshBtnPressed(with image: UIImage?)
    func changeBtnPressed()
    func negativBtnPressed(with image: UIImage?)
}

final class MenuView: UIView {
    // MARK: - IBOutlets
    @IBOutlet private(set) weak var imgView: UIImageView!
    @IBOutlet private weak var matrixButton: UIButton! {
        didSet {
            matrixButton.setTitle(C.matrixTitle, for: .normal)
        }
    }
    @IBOutlet private weak var binarizationButton: UIButton! {
        didSet {
            binarizationButton.setTitle(C.binarizationTitle, for: .normal)
        }
    }
    @IBOutlet private weak var grayButton: UIButton! {
        didSet {
            grayButton.setTitle(C.grayTitle, for: .normal)
        }
    }
    @IBOutlet private weak var normalButton: UIButton! {
        didSet {
            normalButton.setTitle(C.normalTitle, for: .normal)
        }
    }
    @IBOutlet private weak var kirshBtn: UIButton! {
        didSet {
            kirshBtn.setTitle(C.kirshTitle, for: .normal)
        }
    }
    @IBOutlet private weak var changeBtn: UIButton! {
        didSet {
            changeBtn.setTitle(C.changeTitle, for: .normal)
        }
    }
    @IBOutlet private weak var negativBtn: UIButton! {
        didSet {
            negativBtn.setTitle(C.negativTitle, for: .normal)
        }
    }
    // MARK: - Properties
    weak var delegate: MenuViewDelegate?
    
    func updateImageView(_ image: UIImage) {
        imgView.image = image
    }
    
    // MARK: - IBActions
    @IBAction func matrixBtnPressed(_ sender: UIButton) {
        delegate?.matrixBtnPressed()
    }
    @IBAction func binarizationBtnPressed(_ sender: UIButton) {
        delegate?.binarizationBtnPressed(with: imgView.image)
    }
    @IBAction func grayBtnPressed(_ sender: UIButton) {
        delegate?.grayBtnPressed(with: imgView.image)
    }
    @IBAction func normalBtnPressed(_ sender: UIButton) {
        delegate?.normalBtnPressed(with: imgView.image)
    }
    @IBAction func kirshBtnPressed(_ sender: UIButton) {
        delegate?.kirshBtnPressed(with: imgView.image)
    }
    @IBAction func changeBtnPressed(_ sender: UIButton) {
        delegate?.changeBtnPressed()
    }
    @IBAction func negativBtnPressed(_ sender: UIButton) {
        delegate?.negativBtnPressed(with: imgView.image)
    }

}
