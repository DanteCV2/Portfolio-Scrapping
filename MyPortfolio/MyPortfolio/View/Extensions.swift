//
//  Extensions.swift
//  MyPortfolio
//
//  Created by Dante Cervantes Vega on 17/01/20.
//  Copyright © 2020 Dante Cervantes Vega. All rights reserved.
//

import UIKit

extension UIImageView{
    
    func downloadedFrom(link : String,contentMode : UIView.ContentMode = .scaleAspectFit){
        guard let url = URL(string: link) else {return}
        downloadedFrom(url: url)
    }
    
    func downloadedFrom(url : URL, contentMode : UIView.ContentMode = .scaleAspectFit){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil{
                print("Error al descargar imagenes \(error!.localizedDescription)")
            }
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

