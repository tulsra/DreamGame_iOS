
import UIKit

@IBDesignable
class InputView: UIView, UITextFieldDelegate {

    var view: UIView!
    
    @IBOutlet weak var anchorRefView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var accessoryImgView: UIImageView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var accessoryImgWidth: NSLayoutConstraint!
    @IBOutlet weak var accessoryImgBtn: UIButton!
    
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var accessoryImgHeight: NSLayoutConstraint!
    var getUpdatedText:(String)->() = { string in
        
    }
    
    var accessoryAction:(UIButton)->Void = { sender in
        
    }
    
    @IBInspectable var titleText: String = "Title"{
        didSet{
            self.titleLbl.text = titleText
            
        }
    }
    @IBInspectable var placeholderText: String = "Title"{
        didSet{
            self.txtField.placeholder = placeholderText
            
        }
    }
    
    @IBInspectable var text: String = ""{
        didSet{
            self.txtField.text = text
            
        }
    }
    @IBInspectable var isSecuredTextEntry: Bool = false{
        didSet{
            self.txtField.isSecureTextEntry = isSecuredTextEntry
            
        }
    }
    
    @IBInspectable var accessoryImage: UIImage = UIImage(named: "iconNavigationCheck") ?? UIImage() {
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
    
    @IBInspectable var isDropDown: Bool = false {
        didSet {
            
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
        self.txtField.delegate = self
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
        let nib = UINib(nibName: "InputView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        if isDropDown == true {
            accessoryAction(sender)
        }
        else {
            self.txtField.becomeFirstResponder()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let updatedText = NSMutableString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        getUpdatedText(updatedText)
        
        textField.text = updatedText
        return false
    }
    
    @IBAction func accessoryImgAction(_ sender: UIButton) {
        accessoryAction(sender)
    }
}
