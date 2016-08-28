//
//  ViewController.swift
//  MojaveTestApp
//
//  Created by Andrew Cavanagh on 8/27/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import UIKit
import Mojave

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dataSource = DataSource()
        let change = DataSourceChangeset.empty
        dataSource.apply(changeset: change)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

