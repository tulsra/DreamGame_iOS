
import UIKit

@IBDesignable
class PinView: UIView, UITextFieldDelegate {

    var view: UIView!

    @IBOutlet var pinViews: Array<UITextField>?

    
    var getUpdatedText:(String)->() = { string in
        
    }
    
    @IBInspectable var pinText: String = ""{
        didSet{
            
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
        getUpdatedText(updatedText)
        textField.text = updatedText
        
        if updatedText.count == 1 {
            if self.pinViews?.count ?? 0 > (textField.tag + 1)   {
                if let nextView = self.pinViews?[ textField.tag + 1] {
                    nextView.becomeFirstResponder()
                }
            }
            else {
                return false
            }
        }
        else {
            if textField.tag > 0 {
                if let prevView = self.pinViews?[ textField.tag - 1] {
                    prevView.becomeFirstResponder()
                }
            }
        }
        
        return true
    }
    
     @IBAction func btnAction(_ sender: UIButton) {
        var isNotFound = true
        for i in 0...5 {
            if let textField = self.pinViews?[i], textField.text?.count == 0 {
                textField.becomeFirstResponder()
                isNotFound = false
                break
            }
        }
        
        if isNotFound == true {
            self.pinViews?[5].becomeFirstResponder()
        }
    }
    
    func fetchObject<T> (tag: Int, type: T.Type) -> T? {

        for kView in self.pinViews! {
            let kViews = kView.subviews.filter { $0 is T }
            if kViews.count == 1 {
                return (kViews[0] as! T)
            }
        }
        return nil
    }
   
}
