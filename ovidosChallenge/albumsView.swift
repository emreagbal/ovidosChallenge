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
    
    var albumsData = [albumModel](){
        didSet {
            tableView.reloadData()
        }
    }
    
    convenience required init(coder: NSCoder) {
        self.init()
        
        self.albumVM = albumViewModel(delegate: self)
        
    }
    
    
    
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

    // MARK: - Table view data source

    
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
        self.selectedAlbumId = albumsData[indexPath.row].id
        self.performSegue(withIdentifier: "albumsToPhotos", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "albumsToPhotos"{
            let destination = segue.destination as! photosView
            destination.selectedAlbumId = self.selectedAlbumId
        }
    }
    
}
