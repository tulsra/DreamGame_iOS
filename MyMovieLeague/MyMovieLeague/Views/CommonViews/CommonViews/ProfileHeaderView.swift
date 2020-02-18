
import UIKit

@IBDesignable
class ProfileHeaderView: UIView {
    
    var view: UIView!
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var profileImgPlaceholderView: UIImageView!
    @IBOutlet weak var textLbl: UILabel!
    
    var profileImageTapped:()->Void = {
        
    }
    
    var user:User? {
        didSet {
            
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.profileImgView.layer.cornerRadius  =   30
        self.profileImgView.layer.borderWidth   =   2.0
        self.profileImgView.layer.borderColor   =   UIColor.white.cgColor
        self.profileImgView.layer.masksToBounds =   true
  
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ProfileHeaderView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        profileImageTapped()
    }
    
}
