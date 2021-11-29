//import OserioAnalysis2
import OserioScaleComm2


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topbarview: TopBarView!
    @IBOutlet weak var lbOCShow: UILabel!
    var result : AnalysisObject?
    var scaleComm : ScaleComm?
    override func viewDidLoad() {
        super.viewDidLoad()
        runScaleComm()
        if let customView = Bundle(for: TopBarView.self).loadNibNamed("TopBarView", owner: nil, options: nil)?.first as? TopBarView {
            topbarview.addSubview(customView)
            customView.frame = topbarview.bounds
            
            customView.btBack.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
            customView.btBack.isHidden = true
            customView.btTop1.setImage(UIImage(named: "button_general_management_selected"), for: .normal)
            customView.btTop1.addTarget(self, action: #selector(clickTop1), for: .touchUpInside)
            
            
        }
        
        // Do any additional setup after loading the view.
    }
    @objc func clickTop1(_ sender:UIButton){
        print("test click")
        performSegue(withIdentifier: "Add", sender: self)
    }
    @objc func clickBack(_ sender:UIButton){
        print("test click")
    }
    func runScaleComm(){
        scaleComm = ScaleComm()
        scaleComm?.start()
        scaleComm?.isconnectHandler = { [unowned self] isconnect in
            if isconnect {
                print("連線中")
                lbOCShow.text = "連線中"
            }else{
                print("斷線")
            }
        }
        scaleComm?.resultHandler = { [unowned self] r in
            var text = "OC \n"
            text += "weight = \(r.getWeight() ) \n"
            text += "BodyFat = \(r.getBodyFat() ) \n"
            text += "BodyWater = \(r.getBodyWater() ) \n"
            text += "Bmr = \(r.getBmr() ) \n"
            text += "Smr = \(r.getSmr() ) \n"
            text += "Vat = \(r.getVat() ) \n"
            text += "Bone = \(r.getBone() ) \n"
            text += "Muscle = \(r.getMuscle() ) \n"
            text += "BodyAge = \(r.getBodyAge() ) \n"
            text += "Protein = \(r.getProtein() ) \n"
            text += "Score = \(r.getScore()) \n"
            lbOCShow.text = text
        }
    }


}

//extension TopBarView {
//
//    override func clickBack(_ sender:UIButton){
//
//    }
//}
