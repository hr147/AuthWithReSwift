//
//  CustomUITextField.swift
//  AuthenticaionWithRedux
//
//  Created by Haroon Ur Rasheed on 06/10/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

class CustomUITextField: UITextField {
    
    let leftSpace:CGFloat = 16.0
    let rightSpace:CGFloat = 16.0
    let topSpace:CGFloat = 0.0
    let bottomSpace:CGFloat = 0.0
    
    var padding: UIEdgeInsets {
        return UIEdgeInsets(top: topSpace,
                            left: leftSpace,
                            bottom: bottomSpace,
                            right: rightSpace)
    }
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 4.0
        layer.masksToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        font = UIFont(name: "AvenirNextCondensed-Medium", size: 17)
        backgroundColor = UIColor.colorWithRedValue(redValue: 234, greenValue: 234, blueValue: 234, alpha: 1)
        borderStyle = .none
        textColor = .black
        autocorrectionType = .no
    }
}

extension UIColor {
    
    static func colorWithRedValue(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: redValue/255.0, green: greenValue/255.0, blue: blueValue/255.0, alpha: alpha)
    }
    
}
