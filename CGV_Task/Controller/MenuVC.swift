//
//  ViewController.swift
//  CGV_Task
//
//  Created by Денис Андриевский on 22.11.2020.
//

import UIKit

final class MenuVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var mainView: MenuView!
    
    // MARK: - Properties
    private var imageColorer: ImageColorer!
    private var currentImage = #imageLiteral(resourceName: "image1")

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageColorer = DependencyInjection.shared.imageColorer()
        mainView.delegate = self
        mainView.updateImageView(currentImage)
        performImageToByteArrayConvertion()
    }
    
    private func performImageToByteArrayConvertion() {
        guard let image = mainView.imgView.image else { return }
        let data = image.pixelData()
        guard let pixels = data.0 else { return }
        User.shared.pixelUInt8Array = pixels
    }
    
    private func changeImage() {
        currentImage = currentImage == #imageLiteral(resourceName: "image2") ? #imageLiteral(resourceName: "image1") : #imageLiteral(resourceName: "image2")
        mainView.updateImageView(currentImage)
        performImageToByteArrayConvertion()
    }

}
// MARK: - MenuViewDelegate
extension MenuVC: MenuViewDelegate {
    
    func matrixBtnPressed() {
        performSegue(withIdentifier: C.matrixSegueID, sender: self)
    }
    
    func binarizationBtnPressed(with image: UIImage?) {
        guard let userPixels = User.shared.pixelColorArray, let size = image?.size,
              let outputImage = imageColorer.binarize(pixelArray: userPixels, size: size)  else { return }
        mainView.updateImageView(outputImage)
    }
    
    func grayBtnPressed(with image: UIImage?) {
        guard let userPixels = User.shared.pixelColorArray, let size = image?.size,
              let outputImage = imageColorer.grayGradation(pixelArray: userPixels, size: size)  else { return }
        mainView.updateImageView(outputImage)
    }
    
    func normalBtnPressed(with image: UIImage?) {
        mainView.updateImageView(currentImage)
    }
    
    func kirshBtnPressed(with image: UIImage?) {
        guard let pixels = User.shared.pixelColorArray, let img = imageColorer.kirshMethodEdgeRecognition(pixelArray: pixels, size: currentImage.size) else { return }
        
        mainView.updateImageView(img)
    }
    
    func changeBtnPressed() {
        changeImage()
    }
    
    func negativBtnPressed(with image: UIImage?) {
        guard let pixels = User.shared.pixelColorArray, let img = imageColorer.negativ(pixelArray: pixels, size: currentImage.size) else { return }
        
        mainView.updateImageView(img)
    }
    
}

