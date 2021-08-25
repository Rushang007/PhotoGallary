//
//  ImageViewerVC.swift
//  PhotoGallary
//
//  Created by Rushang Patel (iOS Developer) on 25/08/21.
//

import UIKit


class ImageViewer_Cell:UICollectionViewCell
{
    @IBOutlet weak var gallaryimage: UIImageView!

}

class ImageViewerVC: UIViewController {

    var gallary_list:[Gallary] = []
    var selectedindex:IndexPath? = nil
    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionview.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let _index = selectedindex
        {
            self.collectionview.scrollToItem(at: _index, at: .centeredHorizontally, animated: false)
        }
    }

}
extension ImageViewerVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gallary_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewer_Cell", for: indexPath) as! ImageViewer_Cell
        let itm = self.gallary_list[indexPath.item]
        cell.gallaryimage.sd_setImage(with: URL(string: itm.image)!, placeholderImage: UIImage(named: "placeholder"), options: [.progressiveLoad,.continueInBackground], completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionview.frame.size.width, height: self.collectionview.frame.size.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let _index = selectedindex
        {
            self.collectionview.scrollToItem(at: _index, at: .centeredHorizontally, animated: false)
            self.selectedindex = nil
        }
    }
}
