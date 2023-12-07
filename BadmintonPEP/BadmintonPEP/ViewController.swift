//
//  ViewController.swift
//  BadmintonPEP
//
//  Created by sunShine on 2023/12/6.
//

import UIKit
enum style{
    case score11
    case score21
    case score60
}


class ViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    @IBAction func pushToBoard(_ sender: Any) {
        let sb = UIStoryboard(name: "board", bundle: nil)
        let board = sb.instantiateViewController(withIdentifier: "board") as! board
        self.navigationController?.pushViewController(board, animated:true)
    }

}

