//
//  CustomElement.swift
//  Gedeti
//
//  Created by christophe fauchere on 16.12.15.
//  Copyright © 2015 Gedeti Entreprise. All rights reserved.
//

import Foundation
import UIKit

class MyCustomButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = UIColor.grayColor()
        self.tintColor = UIColor.whiteColor()
    }
}
class MyRoundedButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.layer.borderColor = UIColor(red:0.0/255.0, green:122.0/255.0, blue:255.0/255.0, alpha:0).CGColor as CGColorRef
        self.layer.borderWidth = 2.0
        self.clipsToBounds = true
    }
}
/*
class TextFieldAndroid: MKTextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Style Android
        self.setValue(UIColor.lightGrayColor(), forKeyPath: "_placeholderLabel.textColor")
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.floatingPlaceholderEnabled = true
        self.tintColor = UIColor.whiteColor()
        self.bottomBorderEnabled = true
    }
}
*/