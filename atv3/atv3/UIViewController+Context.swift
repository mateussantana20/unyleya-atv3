//
//  UIViewController+Context.swift
//  MoviesLib
//
//  Created by Mateus on 23/04/24.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
