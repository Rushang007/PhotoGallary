//
//  CollCells.swift
//  PhotoGallary
//
//  Created by Rushang Patel (iOS Developer) on 25/08/21.
//

import Foundation
class Coll_Dashboard_Cell:UICollectionViewCell
{
    @IBOutlet weak var gallaryimage: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var selecteditem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func LoadData(itm: Gallary)
    {
        self.gallaryimage.sd_setImage(with: URL(string: itm.image)!, placeholderImage: UIImage(named: "placeholder"), options: [.progressiveLoad,.continueInBackground], completed: nil)
        self.lbl_name.text = itm.name
        self.selecteditem.isHidden =  itm.isselected == nil ? true : !itm.isselected!
    }
    
}

