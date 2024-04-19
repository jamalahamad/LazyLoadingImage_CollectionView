//
//  HomeViewModel.swift
//  LazyLoadingImage
//
//  Created by Jamal Ahamad on 18/04/24.
//

import Foundation

class HomeViewModel {
    
    let apiMngr = ApiManager()
    
    func getData( completion: @escaping ([DataModel])-> Void) {
        
        guard let url = URL(string: URL_STRING)  else {
            print("Invalid Url")
            return
        }
        
        apiMngr.getDataFromApi(url: url, method: .get) { (result: Result<[DataModel], NetworkError>) in
            
            switch result {
            case .success(let resp) :
                print("response", resp)
                completion(resp)
            case .failure(let error) :
                print("error", error)
                completion([DataModel]())
            }
            
        }
    }
}
