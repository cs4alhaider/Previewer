//
//  Helper.swift
//  Previewer
//
//  Created by Abdullah Alhaider on 11/3/19.
//  Copyright © 2019 Abdullah Alhaider. All rights reserved.
//

import Foundation

extension NSMutableArray {
    
    func getClassName() -> String? {
        for lineIndex in 0 ..< self.count {
            guard let line = self[lineIndex] as? String else {
                return nil
            }
            // searching for class keyword...
            if line.contains("class ") {
                // break the string into an array of words
                let wordsArray = line.split(separator: " ")
                // remove the space elemnts
                let filterdWords = wordsArray.filter {
                    $0 != " "
                }
                // get the class element index
                guard let classWordIndex = filterdWords.firstIndex(of: "class") else {
                    return nil
                }
                // get the class name by it's index
                var className = filterdWords[classWordIndex + 1]
                // check if class contains ":" string
                if className.last == ":" {
                    className.removeLast()
                }
                return String(className)
            }
        }
        return nil
    }

}
