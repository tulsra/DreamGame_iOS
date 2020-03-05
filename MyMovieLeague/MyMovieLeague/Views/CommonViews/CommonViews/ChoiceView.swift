
import UIKit

@IBDesignable
class ChoiceView: UIView {

    var view: UIView!
    
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var anchorRefView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var accessoryImgView: UIImageView!
    @IBOutlet weak var accessoryImgWidth: NSLayoutConstraint!
    @IBOutlet weak var accessoryImgBtn: UIButton!
    
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var accessoryImgHeight: NSLayoutConstraint!
    var getUpdatedText:(String)->() = { string in
        
    }
    
    var accessoryAction:(ChoiceView)->Void = { view in
        
    }
    
    @IBInspectable var titleText: String = "Title"{
        didSet{
            self.titleLbl.text = titleText
            
        }
    }
 

    
    @IBInspectable var accessoryImage: UIImage = UIImage(named: "red-unselect") ?? UIImage() {
        didSet{
            self.accessoryImgView.image = accessoryImage
        }
    }
    
    @IBInspectable var accessoryImageSize: CGFloat = 16{
        didSet{
            self.accessoryImgWidth.constant = accessoryImageSize
            self.accessoryImgHeight.constant = accessoryImageSize
            
        }
    }
    
    @IBInspectable var showAccesoryImage: Bool = true {
        didSet{
            self.accessoryImgView.isHidden  =   !showAccesoryImage
            self.accessoryImgBtn.isHidden = !showAccesoryImage
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryImgView.image = UIImage(named: "white-unselect")
        accessoryImgView.alpha = 0.4
        titleLbl.textColor = UIColor(white: 1, alpha: 0.8)
        contentContainerView.layer.cornerRadius = 10
        contentContainerView.layer.borderWidth = 3.0
        contentContainerView.layer.borderColor = UIColor(white: 1, alpha: 0.2).cgColor
        contentContainerView.layer.masksToBounds = true
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
        let nib = UINib(nibName: "ChoiceView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        self.selectAction()
        accessoryAction(self)
       
    }
    

    func unselectAction() {
        accessoryImgBtn.isSelected = false
        accessoryImgView.image = UIImage(named: "white-unselect")
        accessoryImgView.alpha = 0.4
        titleLbl.textColor = UIColor(white: 1, alpha: 0.8)
        contentContainerView.layer.cornerRadius = 10
        contentContainerView.layer.borderWidth = 2.0
        contentContainerView.layer.borderColor = UIColor(white: 1, alpha: 0.2).cgColor
        contentContainerView.layer.masksToBounds = true
    }
    func selectAction() {
        accessoryImgBtn.isSelected = true
        accessoryImgView.alpha = 1
        accessoryImgView.image = UIImage(named: "white-select")
        titleLbl.textColor = UIColor(white: 1, alpha: 1)
        contentContainerView.layer.cornerRadius = 10
        contentContainerView.layer.borderWidth = 2.0
        contentContainerView.layer.borderColor = UIColor(white: 1, alpha: 1).cgColor
        contentContainerView.layer.masksToBounds = true
        
    }
    
    @IBAction func accessoryImgAction(_ sender: UIButton) {
        self.selectAction()
        accessoryAction(self)
    }
}
