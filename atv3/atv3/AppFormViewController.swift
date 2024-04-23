//
//  MovieFormViewController.swift
//  MoviesLib
//
//  Created by Mateus on 23/04/24.
//

import UIKit

class AppFormViewController: UIViewController {
    

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var buttonAddEdit: UIButton!
    
    
    var movie: Model?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            title = "Edição"
            textFieldName.text = movie.name
            textViewDescription.text = movie.descriptionT
            textFieldAddress.text = movie.address
            if let image = movie.image {
                imageViewPoster.image = UIImage(data: image)
            }
            
            buttonAddEdit.setTitle("Alterar", for: .normal)}

    }
    
    @IBAction func selectPoster(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar pôster", message: "De um deseja escolher o poster?", preferredStyle: .actionSheet)
       
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default, handler: { _ in
                self.selectPicture(sourceType: .camera)
            })
            alert.addAction(cameraAction)
        }
       
        let libraryAction = UIAlertAction(title: "Biblioteca de Fotos", style: .default, handler: { _ in
            self.selectPicture(sourceType: .photoLibrary)
        })
        alert.addAction(libraryAction)
        
        let albumAction = UIAlertAction(title: "Álbum de Fotos", style: .default, handler: { _ in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        })
        alert.addAction(albumAction)
        
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func save(_ sender: UIButton) {
        if movie == nil {
            movie = Model(context: context)
        }
        
        movie?.name = textFieldName.text
        movie?.descriptionT = textViewDescription.text
        movie?.address = textFieldAddress.text
        movie?.image = imageViewPoster.image?.jpegData(compressionQuality: 0.9)
        
        try? context.save()
        
        navigationController?.popViewController(animated: true)
    }
}


extension AppFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imageViewPoster.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
