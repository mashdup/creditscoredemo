//
//  String+Localisable.swift
//  clearscoretest
//
//  Created by Dillon Hoa on 19/12/2021.
//

import Foundation

extension String {
    
    func localised() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
