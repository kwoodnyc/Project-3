//
//  UIUtils.swift
//  BoutTime
//
//  Created by Kristopher Wood on 7/12/18.
//  Copyright © 2018 Kristopher Wood. All rights reserved.
//

import UIKit

class UIUtils {
    static func set(interaction: Bool, for buttons: [UIButton]) {
        for button in buttons {
            button.isUserInteractionEnabled = interaction
        }
    }
}
