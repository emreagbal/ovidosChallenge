//
//  photoViewModel.swift
//  ovidosChallenge
//
//  Created by Emre Ağbal on 8.01.2020.
//  Copyright © 2020 Emre Ağbal. All rights reserved.
//

import UIKit


class photoViewModel {
    
    weak var delegate : photosView?
    
    fileprivate var apiURL = "http://jsonplaceholder.typicode.com/photos"
    
    
    init(delegate: photosView) {
        self.delegate = delegate
        fetchDataFromServer()
        
    }
    // MARK: - Data Implementation From Server
    func fetchDataFromServer(){
           
           guard let url = URL(string: apiURL) else { return }
                  let session = URLSession(configuration: .default)
                  session.dataTask(with: url) { (data, response, error) in
                      do {
                          let fetch = try JSONDecoder().decode([photoModel].self, from: data!)
                          
                          DispatchQueue.main.async {
                              
                            self.delegate?.photosData = fetch
                           
                          }
                      }
                      catch {
                          print(error.localizedDescription)
                      }
                  }.resume()
              
       }
}
