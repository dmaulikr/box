import UIKit

class VGridVisorMenu:UIView
{
    private weak var controller:CGridVisor!
    private weak var buttonMatch:VGridVisorMenuButton!
    private weak var buttonDetail:VGridVisorMenuButton!
    private weak var buttonDownload:VGridVisorMenuButton!
    private weak var layoutMatchLeft:NSLayoutConstraint!
    private let kItemWidth:CGFloat = 100
    private let kBottom:CGFloat = -50
    
    init(controller:CGridVisor)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonMatch:VGridVisorMenuButton = VGridVisorMenuButton(image:#imageLiteral(resourceName: "assetGenericMatch"))
        self.buttonMatch = buttonMatch
        
        let buttonDownload:VGridVisorMenuButton = VGridVisorMenuButton(image:#imageLiteral(resourceName: "assetGenericDownload"))
        self.buttonDownload = buttonDownload
        
        addSubview(buttonMatch)
        
        NSLayoutConstraint.topToTop(
            view:buttonMatch,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:buttonMatch,
            toView:self,
            constant:kBottom)
        layoutMatchLeft = NSLayoutConstraint.leftToLeft(
            view:buttonMatch,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonMatch,
            constant:kItemWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonDownload,
            toView:buttonMatch)
        NSLayoutConstraint.rightToLeft(
            view:buttonDownload,
            toView:buttonMatch)
        NSLayoutConstraint.width(
            view:buttonDownload,
            constant:kItemWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainLeft:CGFloat = width - kItemWidth
        let marginLeft:CGFloat = remainLeft / 2.0
        layoutMatchLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
}
