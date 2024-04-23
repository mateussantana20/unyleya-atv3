//
//  MoviesTableViewController.swift
//  MoviesLib
//
//  Created by Mateus on 22/04/24.
//

import UIKit
import CoreData

class AppTableViewController: UITableViewController {
    
    var fetchedRasultsController: NSFetchedResultsController<Model>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItens()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let movieViewController = segue.destination as? AppViewController, 
            let indexPath = tableView.indexPathForSelectedRow {
            movieViewController.appAtv = fetchedRasultsController.object(at: indexPath)
        }
    }
    
    func loadItens () {
        let fetchRequest: NSFetchRequest<Model> = Model.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedRasultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:
            context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedRasultsController.delegate = self
        
        try? fetchedRasultsController.performFetch()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedRasultsController.fetchedObjects?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AppTableViewCell else {
            return UITableViewCell()
        }
                
        let movie = fetchedRasultsController.object(at: indexPath)
        cell.configureWith(movie)
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let movie = fetchedRasultsController.object(at: indexPath)
            context.delete(movie)
            try? context.save()
            
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension AppTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChange anObject: Any, at 
        indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        tableView.reloadData()
    }
}
