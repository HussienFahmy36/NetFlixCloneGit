//
//  SearchResultViewController.swift
//  Netflix clone
//
//  Created by Hussien Gamal Mohammed on 13/10/2023.
//

import UIKit

class SearchResultViewController: UIViewController {

    public var titles: [Title] = []
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        applyConstraints()
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    func applyConstraints() {
        let collectionViewConstraints = [
            searchResultsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchResultsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchResultsCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            searchResultsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 15),
        ]
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}


extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        
        return CGSize(width: 80, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        CGFloat(20)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let title = titles[indexPath.row].poster_path ?? ""
        cell.configure(with: title)
        return cell
    }
}
