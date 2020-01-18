//
//  ProjectsFactory.swift
//  MyPortfolio
//
//  Created by Dante Cervantes Vega on 17/01/20.
//  Copyright © 2020 Dante Cervantes Vega. All rights reserved.
//

import Foundation
import Alamofire
import Kanna

class ProjectsFactory {
    
    var projects = [Project]()
    var pageUrl : String
    
    init(pageUrl : String) {
        self.pageUrl = pageUrl
        scrapeUrl()
    }
    
    func scrapeUrl()  {
        Alamofire.request(self.pageUrl).responseString { (response) in
            if response.result.isSuccess{
                if let htmlString = response.result.value{
                    self.parseHTML(htmlString)
                }
            }
        }
    }
    
    func parseHTML(_ html : String){
        do{
            let doc = try Kanna.HTML(html: html, encoding: .utf8)
            
            for sections in doc.css("section"){
                if sections["class"] == "posts"{
                    for articles in sections.css("article"){
                        var title = ""
                        var imageUrl = ""
                        var description = ""
                        var gitUrl = ""
                        
                        for headers in articles.css("header"){
                            for a in headers.css("a"){
                                title = a.content!.replacingOccurrences(of: "\r\n\t\t\t\t\t\t\t\t\t\t", with: " ")
                            }
                        }
                        
                        for a in articles.css("a"){
                            if a["class"] == "image fit"{
                                imageUrl = a["href"]!
                            }
                        }
                        
                        for p in articles.css("p"){
                            description = p.content!
                        }
                        
                        for ul in articles.css("ul"){
                            if ul["class"] == "actions special"{
                                for a in ul.css("a"){
                                    gitUrl = a["href"]!
                                }
                            }
                        }
                        
                        let project = Project(title: title, description: description, imageUrl: imageUrl, gitUrl: gitUrl)
                        self.projects.append(project)
                        NotificationCenter.default.post(name: NSNotification.Name("articleUpdated"), object: nil)
                    }
                }
            }
            
        }catch{
            print(error)
        }
    }
}
