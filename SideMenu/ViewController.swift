//
//  ViewController.swift
//  SideMenu
//
//  Created by Ali Raza on 17/05/2020.
//  Copyright © 2020 Ali Raza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SideMenuExpose {

    @IBOutlet weak var vSuperContainer: UIView!
    
    var sideMenu: SideMenuCustomView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sideMenu = (self.view as! SideMenuCustomView)
        sideMenu?.sideMenuDelegate = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(actionBarItem(_:)))

    }

    func exposeMenu(_ show: Bool) {
        if show {
            self.view.sendSubviewToBack(vSuperContainer)
        } else {
            self.view.bringSubviewToFront(vSuperContainer)
        }
    }
    
    @objc func actionBarItem(_ sender: UIBarButtonItem) {
        sideMenu?.btnAction()
    }
}

