//
//  AddViewController.swift
//  OserioAnalysis2TestLib
//
//  Created by sunkeeper on 2021/11/29.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var topbarview: TopBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let customView = Bundle(for: TopBarView.self).loadNibNamed("TopBarView", owner: nil, options: nil)?.first as? TopBarView {
            topbarview.addSubview(customView)
            customView.frame = topbarview.bounds
            customView.btBack.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func clickBack(_ sender:UIButton){
        print("test click")
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
