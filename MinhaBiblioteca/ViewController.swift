//
//  ViewController.swift
//  MinhaBiblioteca
//
//  Created by Cristiane Goncalves Uliana on 22/03/21.
//  Copyright © 2021 Estudos. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var autorTextField: UITextField!
    @IBOutlet weak var editoraTextField: UITextField!
    @IBOutlet weak var anoTextField: UITextField!
    @IBOutlet weak var favoritoSwitch: UISwitch!
    
    
    // MARK: - Atributos
    
    var contexto: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    
    @IBAction func salvarButton(_ sender: UIButton) {
        let livro = Livro(context: contexto)
        livro.titulo = tituloTextField.text
        livro.autor = autorTextField.text
        livro.editora = editoraTextField.text
        livro.ano = anoTextField.text
        //livro.favorito = favoritoSwitch
        
        do {
            try contexto.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    
    
}

