//
//  TitleCollectionViewCell.swift
//  Netflix clone
//
//  Created by Hussien Gamal Mohammed on 12/10/2023.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
        
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String) {
        guard let sd_imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else { return }
        posterImageView.sd_setImage(with: sd_imageURL)
    }
}
