//
//  ElementoViewController.swift
//  T4Tut002Coredata
//
//  Created by Efren Alejandro Barroso Llanes on 16/06/15.
//  Copyright (c) 2015 EBL. All rights reserved.
//

import UIKit
import CoreData

class ElementoViewController: UIViewController
{

    var elementosel: Lista? = nil
    
    @IBOutlet var elemento: UITextField!
    @IBOutlet var cantidad: UITextField!
    @IBOutlet var notas: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(elementosel != nil)
        {
            elemento.text = elementosel?.elemento
            cantidad.text = elementosel?.cantidad
            notas.text = elementosel?.info
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func Guardar(sender: UIBarButtonItem)
     {
        let appdel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appdel.managedObjectContext!
        let ent = NSEntityDescription.entityForName("Lista", inManagedObjectContext: context)
        
        if( elementosel == nil )
        {
            var nvoelemento = Lista(entity: ent!, 	insertIntoManagedObjectContext: context)
            nvoelemento.elemento = elemento.text
            nvoelemento.cantidad = cantidad.text
            nvoelemento.info = notas.text
        }
        else
        {
            elementosel!.elemento = elemento.text
            elementosel!.info = notas.text
            elementosel!.cantidad = cantidad.text
        }
        
        context.save(nil)
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func cancelar(sender: UIBarButtonItem)
    {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
