//
//  albumsView.swift
//  ovidosChallenge
//
//  Created by Emre Ağbal on 9.01.2020.
//  Copyright © 2020 Emre Ağbal. All rights reserved.
//

import UIKit

class albumsView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var albumVM : albumViewModel!
    
    var selectedAlbumId : Int = 0
    
    fileprivate var tableView : UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    // MARK: - Data Implementation
    var albumsData = [albumModel](){
        didSet {
            tableView.reloadData()
        }
    }
    
    convenience required init(coder: NSCoder) {
        self.init()
        self.albumVM = albumViewModel(delegate: self)
        
    }
    
    
    // MARK: - View Did Load Operations
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }

    // MARK: - Table View Data Source

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumsData.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = albumsData[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let photosView = mainStoryBoard.instantiateViewController(withIdentifier: "photosView") as? photosView else {
            print("Couldn't find the view")
            return
        }
        
        photosView.selectedAlbumId = albumsData[indexPath.row].id
        present(photosView, animated: true, completion: nil)
        
    }

    
}
