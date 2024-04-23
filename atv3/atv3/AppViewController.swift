//
//  ViewController.swift
//  MoviesLib
//
//  Created by Mateus on 22/04/24.
//

import UIKit

class AppViewController: UIViewController {

    var appAtv: Model?
    
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let appFormViewController = segue.destination as? AppFormViewController {
            appFormViewController.movie = appAtv
        }
    }
    
    func prepareScreen() {
        if let appAtv = appAtv {
            if let image = appAtv.image {
                imageViewPoster.image = UIImage(data: image)
            }
            
            labelName.text = appAtv.name
            labelAddress.text = appAtv.address
            textViewDescription.text = appAtv.descriptionT
        }
    }
    


 }

