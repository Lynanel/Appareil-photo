//
//  ViewController.swift
//  Appareil photo
//
//  Created by TRAORE Lionel on 8/12/19.
//  Copyright © 2019 TRAORE Lionel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageViewChoisie: UIImageView!
    @IBOutlet weak var noImageLable: UILabel!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
   
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if imageViewChoisie.image == nil {
            noImageLable.isHidden = false
        } else {
            noImageLable.isHidden = true
        }
    }

    func presentWithSource(_ source: UIImagePickerController.SourceType) {
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func prendrePhoto(_ sender: UIButton) {
        
        let alertActionSheet = UIAlertController(title: "prendre une photo", message: "Choisissez le media", preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Appareil photo", style: .default){ (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                 self.presentWithSource(.camera)
            } else {
                let alerte = UIAlertController(title: "Erreur", message: "Aucun appareil photo n'est disponible", preferredStyle: .alert)
                
                let annuler = UIAlertAction(title: "Je comprends", style: .destructive, handler: nil)
                alerte.addAction(annuler)
                self.present(alerte, animated: true, completion: nil)
            }
           
        }
        
        let gallery = UIAlertAction(title: "Gallerie de photos", style: .default){ (action) in
            self.presentWithSource(.photoLibrary)
        }
        
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        
        alertActionSheet.addAction(camera)
        alertActionSheet.addAction(gallery)
        alertActionSheet.addAction(cancel)
        
        //Prend en compte les iPad
        if let popover = alertActionSheet.popoverPresentationController {
            popover.sourceView = view
            popover.sourceRect = CGRect(x: view.frame.midX, y: view.frame.midY, width: 0, height: 0 )
            popover.permittedArrowDirections = []
        }
        present(alertActionSheet, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let edite = info[.editedImage] as? UIImage {
            imageViewChoisie.image = edite
        } else if let originale = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageViewChoisie.image = originale
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

