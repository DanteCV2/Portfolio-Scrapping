//
//  ProjectsCollectionView.swift
//  MyPortfolio
//
//  Created by Dante Cervantes Vega on 17/01/20.
//  Copyright © 2020 Dante Cervantes Vega. All rights reserved.
//

import UIKit
import Alamofire


class ProjectsCollectionView: UICollectionViewController {
    
    let myPortfolioUrl = "https://inspiring-wilson-8f50be.netlify.com"
    var factory : ProjectsFactory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadItems), name: NSNotification.Name("projectUpdated"), object: nil)
        factory = ProjectsFactory(pageUrl: myPortfolioUrl)
    }    
    
    //MARK: - Collection View Funcs
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return factory.projects.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        cell.titleLabel.text = factory.projects[indexPath.row].title
        cell.descriptionLabel.text = factory.projects[indexPath.row].description
        cell.imageView.downloadFrom(link: factory.projects[indexPath.row].imageUrl)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = URL(string: factory.projects[indexPath.row].gitUrl){
            UIApplication.shared.open(url, options: [:]) { (succes) in
                print("Hemos ido al articulo: \(self.factory.projects[indexPath.row].title)")
            }
        }
    }
    
    @objc func reloadItems(){
        self.collectionView.reloadData()
    }
}
