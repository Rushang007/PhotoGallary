//
//  DashboardVC.swift
//  PhotoGallary
//
//  Created by Rushang Patel (iOS Developer) on 24/08/21.
//

import UIKit
import SDWebImage
class Coll_Dashboard_Cell:UICollectionViewCell
{
    @IBOutlet weak var gallaryimage: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    
}

class Tbl_Dashboard_Cell:UITableViewCell
{
    
    @IBOutlet weak var gallaryimage: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    
}

class DashboardVC: UIViewController {

    
    @IBOutlet weak var collectionview: UICollectionView!
    
    @IBOutlet weak var tbllist: UITableView!
    var gallary_list:[Gallary] = [] {
        didSet
        {
            DispatchQueue.main.async {
                
                self.isGridView == true ? self.collectionview.reloadData() : self.tbllist.reloadData()
               
            }
            
        }
    }
    var rightButton = UIBarButtonItem()
    let listimage = UIImage(named: "list")
    let gridimage = UIImage(named: "grid")
    var navigationrightbarimage:UIImage? = nil
    var isGridView = true {
        didSet
        {
            navigationrightbarimage = isGridView == true ? gridimage : listimage
            rightButton.image = navigationrightbarimage
            self.isGridView == true ? self.collectionview.reloadData() : self.tbllist.reloadData()
            UIView.animate(withDuration: 0.5) {
                self.tbllist.alpha = self.isGridView == true ? 0 : 1
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Gallary"
        self.tbllist.alpha = 0
        self.GetData()
        navigationrightbarimage = gridimage
         rightButton = UIBarButtonItem(image:navigationrightbarimage,
                                          style: .plain,
                                         target: self,
                                         action: #selector(buttonTapped))
        navigationItem.setRightBarButton(rightButton, animated: true)

        
    }
    
    @objc func buttonTapped(sender: UIBarButtonItem!) {
        // Implement action
        isGridView.toggle()
        
        
    }

    private func GetData()
    {
        NetworkUtility.shared().getApiData(requestUrl: APIS.getdata, resultType: ResponseData.self) { result in
            if let _result = result
            {
                self.gallary_list = _result.gallary
            }
            
            
        }
    }
}
extension DashboardVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gallary_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Coll_Dashboard_Cell", for: indexPath) as! Coll_Dashboard_Cell
        let itm = self.gallary_list[indexPath.item]
        cell.gallaryimage.sd_setImage(with: URL(string: itm.image)!, placeholderImage: UIImage(named: "placeholder"), options: [.progressiveLoad,.continueInBackground], completed: nil)
        //cell.gallaryimage.loadImage(fromURL: URL(string: itm.image)!, placeHolderImage: "placeholder")
        cell.lbl_name.text = itm.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.collectionview.frame.size.width-10)/3
        return CGSize(width: size, height: size)
    }
    
}
extension DashboardVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gallary_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tbl_Dashboard_Cell", for: indexPath) as! Tbl_Dashboard_Cell
        let itm = self.gallary_list[indexPath.item]
        cell.gallaryimage.sd_setImage(with: URL(string: itm.image)!, placeholderImage: UIImage(named: "placeholder"), options: [.progressiveLoad,.continueInBackground], completed: nil)
        cell.lbl_name.text = itm.name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
