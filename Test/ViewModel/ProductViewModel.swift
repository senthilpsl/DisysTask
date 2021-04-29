//
//  ProductViewModel.swift
//  Test
//
//  Created by Mac Air on 26/04/21.
//  Copyright © 2021 Mac Air. All rights reserved.
//

import UIKit

class ProductViewModel: NSObject {

    var productModels: String?

    func getData(parameterArr: Array<Any> , completion: @escaping ((Bool?, Error?) -> ())) {
        NetworkClient().getData(parameterArr: parameterArr) { (data, error) in
            guard let _data = data else {
                completion(nil, error)
                return
            }
            do {
                let data = try JSONDecoder().decode(ProductResponse.self, from: _data)
                
                self.productModels = data.message;
                completion(true, nil)
            } catch {
                print(error)
                completion(false, error)
            }
        }
    }
    
    
}
