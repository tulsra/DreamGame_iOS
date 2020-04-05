
import UIKit

@IBDesignable
class PinView: UIView, UITextFieldDelegate {

    var view: UIView!

    @IBOutlet var pinViews: Array<UITextField>?

    
    var getUpdatedText:(String)->() = { string in
        
    }
    
    @IBInspectable var pinText: String = ""{
        didSet{
            print(pinText)
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for kView in self.pinViews! {
            kView.backgroundColor = themeColor.withAlphaComponent(0.3)
            kView.layer.masksToBounds = true
            kView.layer.cornerRadius = 2
           kView.delegate = self
        }
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
        let nib = UINib(nibName: "PinView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = NSMutableString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        textField.text = updatedText
                
        if updatedText.count == 0 {
            if let next = self.pinViews?.filter{$0.tag == textField.tag-1}.first {
                next.becomeFirstResponder()
            }
        }
        else {
            if let next = self.pinViews?.filter{$0.tag == textField.tag+1}.first {
                next.becomeFirstResponder()
            }
            else {
                self.endEditing(true)
            }
        }
                
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.pinText = self.pinViews?.filter{$0.tag < textField.tag}.map {"\($0.text!)"}.joined(separator: "") ?? ""
        for txtFld in self.pinViews?.filter{$0.tag >= textField.tag} ?? []{
            txtFld.text = ""
        }
        
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
         self.pinText = self.pinViews?.filter{$0.tag <= textField.tag}.map {"\($0.text!)"}.joined(separator: "") ?? ""
    }
   
}
