//
//  NetworkUtility.swift
//  PhotoGallary
//
//  Created by Rushang Patel (iOS Developer) on 24/08/21.
//

import Foundation

class NetworkUtility
{
    private static var sharedInstance: NetworkUtility?
    class func shared() -> NetworkUtility { // change class to final to prevent override
        guard let uwShared = sharedInstance else {
            sharedInstance = NetworkUtility()
            return sharedInstance!
        }
        return uwShared
    }
    
    class func destroy() {
        sharedInstance = nil
    }
    func getApiData<T:Decodable>(requestUrl: String, resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void)
    {
        let manager = AFHTTPSessionManager()
        manager.get(requestUrl, parameters: nil, headers: nil, progress: nil) { operation, responseObject in
            if let repsonse = responseObject
            {
               if let dataJson = try? JSONSerialization.data(withJSONObject: repsonse, options: JSONSerialization.WritingOptions.prettyPrinted)
               {
               if  let objCodable = try? JSONDecoder().decode(resultType, from: dataJson) as? ResponseData
               {
                _=completionHandler(objCodable.Data as? T)
               }
               
               }
                
            }
         
        } failure: { operation, error in
            print("Error: " + error.localizedDescription)
        }
    
    }
}
