//
//  Double.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-14.
//

import Foundation

extension Double {
    ///Converts a Double into a Currency with 2 decimal places
    /// ```
    ///Convert 1234.56 to $1,234.56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current // <- default value
        //formatter.currencyCode = "usd" // <- change currency
        //formatter.currencySymbol = "$" // <- change currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    ///Converts a Double into a string with 2 decimal places
    /// ```
    ///Convert 12.000000 to 12.0
    /// ```
    private var reviewFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        //formatter.locale = .current // <- default value
        //formatter.currencyCode = "usd" // <- change currency
        //formatter.currencySymbol = "$" // <- change currency symbol
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        return formatter
    }
    
    ///Converts a Double into a Currency as a String with 2-6 decimal places
    /// ```
    ///Convert 1234.56 to "$1,234.56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    ///Converts a Double into a String with 2 decimal places
    /// ```
    ///Convert 14.00000 to "14.5"
    /// ```
    func asReviewWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return reviewFormatter2.string(from: number) ?? "0.0"
    }
    
}
