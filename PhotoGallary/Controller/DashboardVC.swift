//
//  DashboardVC.swift
//  PhotoGallary
//
//  Created by Rushang Patel (iOS Developer) on 24/08/21.
//

import UIKit

class DashboardVC: UIViewController {

    var gallary_list:[Gallary] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.GetData()
        
    }
    private func GetData()
    {
        NetworkUtility.shared().getApiData(requestUrl: APIS.getdata, resultType: ResponseData.self) { result in
            print(result)
        }
    }
}
