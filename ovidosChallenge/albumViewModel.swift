//
//  albumViewModel.swift
//  ovidosChallenge
//
//  Created by Emre Ağbal on 8.01.2020.
//  Copyright © 2020 Emre Ağbal. All rights reserved.
//

import UIKit

class albumViewModel {

    weak var delegate : albumsView?
    
    fileprivate var apiURL = "http://jsonplaceholder.typicode.com/albums"
              
    init(delegate: albumsView) {
        self.delegate = delegate
        fetchDataFromServer()
    }

    // MARK: - Data Implementation From Server
    func fetchDataFromServer(){
              
        guard let url = URL(string: apiURL) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
                         
                do {
                    let fetch = try JSONDecoder().decode([albumModel].self, from: data!)
                             
                    DispatchQueue.main.async {
                                 
                        self.delegate?.albumsData = fetch
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
        }.resume()
                 
    }
}
