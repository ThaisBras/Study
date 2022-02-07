//
//  String+Localization.swift
//  Study
//
//  Created by thais on 07/02/22.
//

import func Foundation.NSLocalizedString

extension String{
    
    func localized() -> String {
        return NSLocalizedString(
                    self,
                    tableName: "Localization",
                    bundle: .main,
                    value: self,
                    comment: self
                )
    }
}
