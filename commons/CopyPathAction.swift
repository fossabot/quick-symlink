//
//  CopyPathAction.swift
//  quick-symlink
//
//  Created by Alexander A. Kropotin on 15/07/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Foundation
import FinderSync

public class CopyPathAction: QuickSymlinkAction {
    
    private var finderController: FIFinderSyncController;

    public init() {
        self.finderController = FIFinderSyncController.default();
    }
    
    public func execute() {
        //Get all selected path
        guard let target = self.finderController.selectedItemURLs() else {
            NSLog("FinderSync() failed to obtain targeted URLs: %@");
            
            return;
        }
        
        // Append all selected paths to string
        var paths = ""
        for path in target {
            paths.append(contentsOf: path.relativePath);
            paths.append(";");
        }
        paths.removeLast();
        
        //Copy path list to clipboard
        let pasteboard = NSPasteboard.init(name: NSPasteboard.Name.init(rawValue: "qs"));
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil);
        pasteboard.setString(paths, forType: NSPasteboard.PasteboardType.string);
    }
}
