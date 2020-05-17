//
//  SideMenuListTableViewCell.swift
//
//  Created by User on 05/05/2016.
//

import UIKit

class SideMenuListTableViewCell: UITableViewCell {

    var view: UIView!
    
    @IBOutlet weak var btnCellSelection: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor                = UIColor.clear
        self.contentView.backgroundColor    = UIColor.clear
        self.selectionStyle                 = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SideMenuListTableViewCell", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
}
