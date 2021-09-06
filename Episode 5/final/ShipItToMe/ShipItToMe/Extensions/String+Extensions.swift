//
//  String+Extensions.swift
//  String+Extensions
//
//  Created by Peter Friese on 03.09.21.
//

import Foundation

private let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
private let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
private let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
private let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

extension String {
  func isEmail() -> Bool {
    return emailPredicate.evaluate(with: self)
  }
}
