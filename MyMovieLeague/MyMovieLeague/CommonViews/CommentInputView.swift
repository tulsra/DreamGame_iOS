
import UIKit

@IBDesignable
class CommentInputView: UIView, UITextViewDelegate {

    var view: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var txtView: UITextView!
    
    var getUpdatedText:(String)->() = { string in
        
    }
    
    @IBInspectable var titleText: String = "Title"{
        didSet{
            self.titleLbl.text = titleText
            
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
        self.txtView.delegate = self
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
        let nib = UINib(nibName: "CommentInputView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let updatedText = NSMutableString(string: textView.text).replacingCharacters(in: range, with: text)
        getUpdatedText(updatedText)
        
        return true
    }
}
