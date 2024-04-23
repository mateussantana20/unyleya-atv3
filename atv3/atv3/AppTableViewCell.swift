//
//  MovieTableViewCell.swift
//  MoviesLib
//
//  Created by Mateus on 22/04/24.
//

import UIKit

class AppTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(_ movie: Model) {
        labelName.text = movie.name
        //labelProblem.text = "\(movie.appDateProblem)"
      
        if let image = movie.image {
            imageViewPoster.image = UIImage(data: image)
        }
    }

}
