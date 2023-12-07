//
//  board.swift
//  BadmintonPEP
//
//  Created by sunShine on 2023/12/7.
//
import UIKit
import Foundation



class board: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }


    
}
