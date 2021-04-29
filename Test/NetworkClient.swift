//
//  NetworkClient.swift
//  Test
//
//  Created by Mac Air on 26/04/21.
//  Copyright © 2021 Mac Air. All rights reserved.
//

import UIKit

let kUrl = "https://api.qa.mrhe.gov.ae/mrhecloud/v1.4/api/iskan/v1/certificates/towhomitmayconcern"

let ksecretKey = "20891a1b4504ddc33d42501f9c8d2215fbe85008"

class NetworkClient: NSObject {
    
    func getData(parameterArr: Array<Any>,completion: @escaping ((Data?, Error?) -> ())) {
       
        let urlStr = kUrl
        let finalUrl = URL(string: urlStr)!

        var request = URLRequest(url: finalUrl)
         request.setValue("consumer-key", forHTTPHeaderField: "mobile_dev")
         request.setValue("consumer-secret", forHTTPHeaderField: ksecretKey)
       
        
       let postParams  = ["name":(parameterArr[0]),"emailaddress":(parameterArr[1]),"mobileno":(parameterArr[2])]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: postParams)
        


        request.httpMethod = "POST"
        request.httpBody = jsonData
        print(finalUrl)
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let unwrappedData = data else { completion(nil, error); return }
            completion(unwrappedData, nil)
        }).resume()
    }
    
}
