//
//  CollectionViewCell.swift
//  LazyLoadingImage
//
//  Created by Jamal Ahamad on 18/04/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var imgview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgview.contentMode = .scaleAspectFit
        imgview.clipsToBounds = true
        self.parentView.cardView()

    }
    
    func setUpCell(model: DataModel) {
        let imgUrl  = model.thumbnail.domain + "/" + model.thumbnail.basePath + "/0/" + model.thumbnail.key
    }

}
