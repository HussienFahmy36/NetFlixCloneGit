//
//  HeroHeaderUIView.swift
//  Netflix clone
//
//  Created by Hussien Gamal Mohammed on 12/10/2023.
//

import UIKit

class HeroHeaderUIView: UIView {
    private let downloadButton: UIButton = {
       let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button

    }()
    private let playButton: UIButton = {
       let button = UIButton()
        button.setTitle("play", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5

        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    private let heroImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }

    
    public func configure(with model: TitleViewModel) {
        guard let sd_imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return }
        heroImageView.sd_setImage(with: sd_imageURL)
    }
    
    private func applyConstraints() {
        // (bounds.width / 2) - (bounds.width * 0.3)
        let playButtonConstraints = [
            playButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: CGFloat(-playButton.frame.width))
        ]

        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -10),
            downloadButton.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
            downloadButton.widthAnchor.constraint(equalTo: playButton.widthAnchor, multiplier: 1)
        ]
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
}
