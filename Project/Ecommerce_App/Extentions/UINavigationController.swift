//
//  UINavigationController.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-15.
//

import Foundation
import SwiftUI

//MARK: - FOR SlIDING THE CHILD VIEW
extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
