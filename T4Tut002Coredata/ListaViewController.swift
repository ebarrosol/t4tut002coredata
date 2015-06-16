//
//  ListaViewController.swift
//  T4Tut002Coredata
//
//  Created by Efren Alejandro Barroso Llanes on 16/06/15.
//  Copyright (c) 2015 EBL. All rights reserved.
//

import UIKit
import CoreData

class ListaViewController: UITableViewController
{

    var lalista : Array<AnyObject> = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        let appdel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appdel.managedObjectContext!
        let freq : NSFetchRequest = NSFetchRequest(entityName: "Lista")
        lalista = context.executeFetchRequest(freq, error: nil)!
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return lalista.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellid : String = "cell"
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellid) as! UITableViewCell
        
        var data : NSManagedObject = lalista[indexPath.row] as! NSManagedObject
        
        cell.textLabel!.text = (data.valueForKeyPath("elemento") as! String)
        
        var cantidad : String = (data.valueForKeyPath("cantidad") as! String)
        var info : String = (data.valueForKeyPath("info") as! String)
        cell.detailTextLabel!.text = "\(cantidad) elemento(s) - \(info)"
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let appdel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appdel.managedObjectContext!
        
        if ( editingStyle == UITableViewCellEditingStyle.Delete )
        {
            context.deleteObject(lalista[indexPath.row] as! NSManagedObject)
            lalista.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            if( !context.save(nil) )
            {
                abort()
            }
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier=="editar")
        {
            var elementosel : Lista = lalista[self.tableView.indexPathForSelectedRow()!.row] as! Lista
            let EVC : ElementoViewController = segue.destinationViewController as! ElementoViewController
            EVC.elementosel = elementosel
            
        }
    }

}
