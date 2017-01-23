//
//  DocumentsDirectoryManager.swift
//  Dipio
//
//  Created by Alex Golub on 11/11/16.
//  Copyright © 2016 Codeveyor. All rights reserved.
//

import Foundation
import UIKit

struct DocumentsDirectoryManager {
    static func filePath(for fileName: String) -> URL {
        let documentDirectory = documentsDirectoryPath() + "/"
        let string = documentDirectory.appending(fileName)
        return URL(fileURLWithPath: string)
    }

    static func documentsDirectoryURL() -> NSURL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
    }

    static func documentsDirectoryPath() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }

    static func endAudioSession(for entityName: String) {
        let fileManager = FileManager.default
        let fileNamesArray = fileManager.subpaths(atPath: documentsDirectoryPath())!
        for fileNameString in fileNamesArray {
            if fileNameString.hasSuffix(".aac") && fileNameString.hasPrefix(entityName) {
                let filePathURL = filePath(for: fileNameString)
                do {
                    try fileManager.removeItem(at: filePathURL)
                } catch let error { print(error) }
            }
        }
    }
}
