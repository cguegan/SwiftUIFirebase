//
//  String+EmailValidation.swift
//  SupabaseAuth
//
//  Created by Christophe Guégan on 10/05/2025.
//

import Foundation

extension String {
    
    /// Validate if the string is a valid email address.
    /// - Returns: `true` if the string is a valid email address, `false` otherwise.
    ///
    /// A valid email address must match the pattern defined by the regex.
    ///
    /// The regex checks for:
    /// - One or more characters before the '@' symbol, which can include letters
    ///   digits, dots, underscores, percent signs, plus signs, and hyphens.
    /// - A domain name that includes letters, digits, dots, and hyphens.
    /// - A top-level domain that consists of 2 to 64 letters (e.g., ".com", ".org", ".co.uk").
    ///
    func isValidEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    /// Validate if the string is a valid password.
    /// - Returns: `true` if the string is a valid password, `false` otherwise.
    ///
    /// A valid password must be at least 8 characters long, contain:
    ///     - at least one uppercase letter,
    ///     - one lowercase letter,
    ///     - one digit,
    ///     - and one special character.
    ///
    func isValidPassword() -> Bool {
        let regex = #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
}
