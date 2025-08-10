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
    func isValidEmail() -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
}
            
