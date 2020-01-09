//
//  photosView.swift
//  ovidosChallenge
//
//  Created by Emre Ağbal on 8.01.2020.
//  Copyright © 2020 Emre Ağbal. All rights reserved.
//

import UIKit
import SDWebImage

class photosView: UIViewController {

    var photoVM : photoViewModel!
    
    var selectedAlbumId : Int = 0
    
    var photosData = [photoModel](){
        didSet {
            reloadData()
        }
    }
    
    convenience required init(coder: NSCoder) {
        self.init()
        self.photoVM = photoViewModel(delegate: self)
    }

    
    
    fileprivate let collectionView : UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(customCell.self, forCellWithReuseIdentifier: "cell")
        return cv
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .darkGray
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true

       
    }


}

extension photosView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 20)/2, height: collectionView.frame.height/3)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! customCell
        cell.data = photosData[indexPath.row]
        
        return cell
    }
    func reloadData(){
        collectionView.reloadData()
    }
}

class customCell: UICollectionViewCell {
    var data : photoModel? {
        didSet{
            guard let data = data else {return}
            image.sd_setImage(with: URL(string: data.url), completed: nil)
            title.text = data.title
        }
    }
    
    
    fileprivate let image: UIImageView =
    {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    fileprivate let title: UILabel = {
        let label = UILabel()
        label.highlightedTextColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        contentView.addSubview(image)
        contentView.addSubview(title)
        image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
