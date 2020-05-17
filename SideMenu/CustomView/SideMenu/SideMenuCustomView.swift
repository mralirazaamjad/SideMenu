//
//  SideMenuCustomView.swift
//  SideMenu
//
//  Created by Ali Raza on 17/05/2020.
//  Copyright © 2020 Ali Raza. All rights reserved.
//

import UIKit

protocol SideMenuExpose {
    
    func exposeMenu(_ show: Bool)
}

class SideMenuCustomView: UIView , UITableViewDataSource, UITableViewDelegate {

    // Our custom view from the XIB file
    var view: UIView!
    var sideMenuDelegate : SideMenuExpose!

    @IBOutlet weak var vSideMenu                 : UIView!
    @IBOutlet weak var tblViewMenu               : UITableView!
    
    var sideMenuListFunctions = [(() -> ())]()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        xibSetup()
        
    }
    
    func xibSetup() {
       
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)
        
        tblViewMenu.register(SideMenuListTableViewCell.self, forCellReuseIdentifier: "Cell")
        tblViewMenu.register(UINib(nibName: "SideMenuListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        
        sideMenuListFunctions.append(selectFunc1)
        sideMenuListFunctions.append(selectFunc2)
        sideMenuListFunctions.append(selectFunc3)
        sideMenuListFunctions.append(selectFunc4)
        sideMenuListFunctions.append(selectFunc5)
        
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SideMenuCustomView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    //MARK: Cell Click Functions
    private func selectFunc1() {
        print("selectFunc1")
    }
    
    private func selectFunc2() {
        print("selectFunc2")
    }
    
    private func selectFunc3() {
        print("selectFunc3")
    }
    
    private func selectFunc4() {
        print("selectFunc4")
    }
    
    private func selectFunc5() {
        print("selectFunc5")
    }
    
    //MARK: SideMenu - This function is only called if you set a completionDelegate in your slideInFromLeft() call
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("Animation stopped")
        if !vSideMenu.isHidden {

        } else {
            sideMenuDelegate.exposeMenu(false)
        }
    }
    
    func exposeLeftMenu() {
        vSideMenu.isHidden    = !vSideMenu.isHidden
        sideMenuDelegate.exposeMenu(!vSideMenu.isHidden)
        vSideMenu.slideInFromLeft(0.5, completionDelegate: self)
    }
    
    //MARK: Actions
    func btnAction() {
        
        if vSideMenu.isHidden {
            exposeLeftMenu()
        } else {
            hideSideMenu()
        }
    }
    
    func hideSideMenu() {
        
        if !vSideMenu.isHidden {
            vSideMenu.isHidden    = true
            vSideMenu.slideOutToLeft(0.5, completionDelegate: self)
        }
    }
    
    @IBAction func actionToDissmisSideMenu(_ sender: UITapGestureRecognizer) {
        hideSideMenu()
    }
    
    //MARK: UITableview Delegate and DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewMenu.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SideMenuListTableViewCell
        
        cell?.textLabel!.text = "Cell \(indexPath.row)"
        cell?.btnCellSelection.tag = indexPath.row
        cell?.btnCellSelection.addTarget(self, action: #selector(selectionFromMenuTableItems(_:)), for: UIControl.Event.touchUpInside)
        
        return cell!
    }
    
    @objc func selectionFromMenuTableItems(_ sender: UIButton) {
        self.sideMenuListFunctions[sender.tag]()
        self.hideSideMenu()
    }
}


extension UIView {
    
    func animateConstraintWithDuration(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, options: UIView.AnimationOptions = [], completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay:delay, options:options, animations: { [weak self] in
            self?.layoutIfNeeded() ?? ()
            }, completion: completion)
    }
    /**set view border color and width and corner radius*/
    
    
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(_ duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate = completionDelegate as? CAAnimationDelegate {
            slideInFromLeftTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    func slideOutToLeft(_ duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideOutToLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate = completionDelegate as? CAAnimationDelegate {
            slideOutToLeftTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        slideOutToLeftTransition.type = CATransitionType.push
        slideOutToLeftTransition.subtype = CATransitionSubtype.fromRight
        slideOutToLeftTransition.duration = duration
        slideOutToLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideOutToLeftTransition.fillMode = CAMediaTimingFillMode.backwards
        
        // Add the animation to the View's layer
        self.layer.add(slideOutToLeftTransition, forKey: "slideOutToLeftTransition")
    }

}
