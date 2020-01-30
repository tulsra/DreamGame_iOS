//
//  ImagePicker.swift
//  BES
//
//  Created by YPO  on 19/08/19.
//  Copyright © 2019 Prathyusha Chiluveru. All rights reserved.
//

import Foundation
import UIKit

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
    func removeImage()
}

open class ImagePicker: NSObject {
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    private var isDestructiveNeeded:Bool?
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate, destructiveNeeded: Bool) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
        self.pickerController.navigationBar.tintColor = AppController.shared.window?.rootViewController?.view.tintColor
        
        self.isDestructiveNeeded = destructiveNeeded
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func present(from sourceView: UIView) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }
        if isDestructiveNeeded ?? false {
            alertController.addAction(UIAlertAction(title: "Delete Profile Picture", style: .destructive, handler: { (action) in
                
                let alertRemove = UIAlertController(title: "Delete Profile Picture", message: "Are you sure you want to delete profile picture?", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action1) in
                    self.delegate?.removeImage()
                })
                alertRemove.addAction(cancelAction)
                alertRemove.addAction(okAction)
                self.presentationController?.present(alertRemove, animated: true, completion: nil)
                
            }))
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        self.presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        
        self.delegate?.didSelect(image: image)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePicker: UINavigationControllerDelegate {
    
}
