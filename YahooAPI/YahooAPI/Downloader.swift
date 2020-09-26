//
//  Downloader.swift
//  YahooAPI
//
//  Created by Rania Arbash on 2020-03-13.
//  Copyright © 2020 Rania Arbash. All rights reserved.
//

import Foundation


class Downloader {
    
    var results : NSArray! = nil
    
    func download(text: String)  {
        let url = URL(string: "http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=\(text)&region=1&lang=en")!
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    
                return
            }
            if let mimeType = httpResponse.mimeType,
                let data = data
                 {
               
                do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                    
                    self.results  =  jsonObject.value(forKeyPath: "ResultSet.Result") as! NSArray
                }catch{
                    
                }
                
                DispatchQueue.main.async {
                    // send notification
                    NotificationCenter.default.post(name: Notification.Name("WepAPIIsReady"), object: nil)
                    
                    }
            }
        }
        task.resume()
        
        
    }
    
}
