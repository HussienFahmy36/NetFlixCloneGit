//
//  Extensions.swift
//  Netflix clone
//
//  Created by Hussien Gamal Mohammed on 12/10/2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
