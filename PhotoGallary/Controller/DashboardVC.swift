//
//  DashboardVC.swift
//  PhotoGallary
//
//  Created by Rushang Patel (iOS Developer) on 24/08/21.
//

import UIKit
import SDWebImage


class DashboardVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var tbllist: UITableView!
    
    //MARK:- Variables
    var refreshControl = UIRefreshControl()
    var refreshControlforTBL = UIRefreshControl()
    var layouttypeButton = UIBarButtonItem()
    var deletebutton  = UIBarButtonItem()
    var selectbutton  = UIBarButtonItem()
    var logoutbutton  = UIBarButtonItem()
    let listimage = UIImage(named: "list")
    let gridimage = UIImage(named: "grid")
    let deleteimage = UIImage(named: "delete")
    var navigationrightbarimage:UIImage? = nil
    var OriginalgGallary_list: [Gallary] = []
    var isselectionEnable = false {
        didSet{
            self.selectbutton.title = isselectionEnable == true ? "Cancel" : "Select"
            
        }
    }
    var isGridView = true {
        didSet
        {
            navigationrightbarimage = isGridView == true ? gridimage : listimage
            layouttypeButton.image = navigationrightbarimage
            self.isGridView == true ? self.collectionview.reloadData() : self.tbllist.reloadData()
            UIView.animate(withDuration: 0.5) {
                self.tbllist.alpha = self.isGridView == true ? 0 : 1
            }
            
        }
    }
    var selectedgallary_list: [Gallary] = [] {
        didSet
        {
            let _selectedgallary_list = selectedgallary_list.filter({$0.isselected!}).count
            deletebutton.image = _selectedgallary_list  == 0 ? nil : deleteimage
            
        }
        
    }
    
    var gallary_list:[Gallary] = [] {
        didSet
        {
            DispatchQueue.main.async {
                self.selectedgallary_list = self.gallary_list.filter({$0.isselected != nil})
                self.collectionview.reloadData()
                self.tbllist.reloadData()
                
            }
            
        }
    }
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Gallary"
        addRefreshControl()
        self.collectionview.alwaysBounceVertical = true
        self.tbllist.alpha = 0
        self.GetData()
        navigationrightbarimage = gridimage
        SetNavigationButtons()
        deletebutton.image = nil
        
    }
    
    
    //MARK:- Selectors Methods
    @objc func refresh(_ sender:AnyObject) {
        self.collectionview.refreshControl?.beginRefreshing()
        self.tbllist.refreshControl?.beginRefreshing()
        self.gallary_list = self.OriginalgGallary_list
        self.refreshControl.endRefreshing()
        self.refreshControlforTBL.endRefreshing()
    }
    
    
    @objc func buttonTapped(sender: UIBarButtonItem!) {
        // Implement action
        isGridView.toggle()
        
        
    }
    @objc func DeletebuttonTapped(sender: UIBarButtonItem!) {
      
        self.gallary_list = Array(Set(self.gallary_list).subtracting(self.selectedgallary_list))
        isselectionEnable.toggle()
        
    }
    @objc func SelectbuttonTapped(sender: UIBarButtonItem!) {
       
       print("selectbuttonTapped")
        isselectionEnable.toggle()
        if !isselectionEnable
        {
            //self.gallary_list = self.OriginalgGallary_list
            self.gallary_list = self.gallary_list.map({ item in
                var updatedTag = item
                if self.gallary_list.map({ $0.isselected }).contains(updatedTag.isselected) {
                    updatedTag.isselected = nil
                }
                return updatedTag
            })
            print(self.gallary_list.count)
        }
        
    }
    
    @objc func LogoutbuttonTapped(sender: UIBarButtonItem!) {
       
        KeychainManager.sharedInstance.RemoveAllData()
        
        GetDelegateScane()?.MoveToScreens()
    }
    private func addRefreshControl()
    {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Refreshing ...")
        self.refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        self.collectionview.addSubview(refreshControl)
        refreshControlforTBL = UIRefreshControl()
        self.refreshControlforTBL.attributedTitle = NSAttributedString(string: "Refreshing ...")
        self.refreshControlforTBL.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        self.tbllist.addSubview(refreshControlforTBL)
    }
   
    private func SetNavigationButtons()
    {
        layouttypeButton = UIBarButtonItem(image:navigationrightbarimage,
                                           style: .plain,
                                           target: self,
                                           action: #selector(buttonTapped))
        deletebutton =  UIBarButtonItem(image:deleteimage,
                                        style: .plain,
                                        target: self,
                                       action: #selector(DeletebuttonTapped))
        
        selectbutton =  UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(SelectbuttonTapped))
        logoutbutton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(LogoutbuttonTapped))
       
        navigationItem.rightBarButtonItems = [layouttypeButton,selectbutton,deletebutton]
        navigationItem.leftBarButtonItem = logoutbutton
    }
    private func GetData()
    {
        DispatchQueue.main.async {
            ProgressView.shared.startAnimating(view: self.view)
        }
        NetworkUtility.shared().getApiData(requestUrl: APIS.getdata, resultType: ResponseData.self) { result in
            DispatchQueue.main.async {
                ProgressView.shared.stopAnimatimating()
            }
            if let _result = result
            {
                self.gallary_list = _result.gallary
                self.OriginalgGallary_list = _result.gallary
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
        cell.LoadData(itm: itm)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.collectionview.frame.size.width-10)/3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isselectionEnable
        {
            var itm = self.gallary_list[indexPath.item]
            itm.isselected = itm.isselected == nil ? true : (itm.isselected! == true ? false : true)
            self.gallary_list[indexPath.item] = itm
        }
        else
        {
            let vc = self.storyboard?.instantiateViewController(identifier: "ImageViewerVC") as! ImageViewerVC
            vc.gallary_list = self.gallary_list
            vc.selectedindex = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
        }

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
        cell.LoadData(itm: itm)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isselectionEnable
        {
            var itm = self.gallary_list[indexPath.item]
            itm.isselected = itm.isselected == nil ? true : (itm.isselected! == true ? false : true)
            self.gallary_list[indexPath.item] = itm
        }
        else
        {
            let vc = self.storyboard?.instantiateViewController(identifier: "ImageViewerVC") as! ImageViewerVC
            vc.gallary_list = self.gallary_list
            vc.selectedindex = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
