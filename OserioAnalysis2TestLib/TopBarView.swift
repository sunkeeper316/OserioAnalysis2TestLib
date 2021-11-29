

import UIKit

class TopBarView: UIView {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var btTop1: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func clickBack(_ sender: UIButton) {
        print("clickBack")
    }
    
}
