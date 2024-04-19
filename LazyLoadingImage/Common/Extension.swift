//
//  Extension.swift
//  LazyLoadingImage
//
//  Created by Jamal Ahamad on 18/04/24.
//

import Foundation
import UIKit

extension UIView{
    func cardView() -> Void {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.5
    }
}

