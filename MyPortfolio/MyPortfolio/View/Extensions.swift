//
//  Extensions.swift
//  MyPortfolio
//
//  Created by Dante Cervantes Vega on 17/01/20.
//  Copyright © 2020 Dante Cervantes Vega. All rights reserved.
//

import UIKit

extension UIImageView{
    
    func downloadFrom(link : String, contentMode : UIView.ContentMode = .scaleAspectFit){
        
        guard let url = URL(string: link) else {return}
        downloadFrom(url: url)
    }
    
    func downloadFrom(url : URL, contentMode : UIView.ContentMode = .scaleAspectFit){
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
           guard
               let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200,
               let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
               let data = data, error == nil,
               let image = UIImage(data: data)
               else{return}
           DispatchQueue.main.async {
               self.image = image
            }
        }.resume()
    }
}
