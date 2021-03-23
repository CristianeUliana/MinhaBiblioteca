//
//  HomeTableViewController.swift
//  MinhaBiblioteca
//
//  Created by Cristiane Goncalves Uliana on 22/03/21.
//  Copyright © 2021 Estudos. All rights reserved.
//

import UIKit
import CoreData


class HomeTableViewController: UITableViewController {
    
    //MARK: - Variáveis
    
    var contexto:NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    var gerenciadorDeResultados:NSFetchedResultsController<Livro>?
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recuperaLivros()
    }

    
    // MARK: - Métodos
    
    func recuperaLivros() {
        let recuperaLivro: NSFetchRequest<Livro> = Livro.fetchRequest()
        let ordenaPorNome = NSSortDescriptor(key: "titulo", ascending: true)
        recuperaLivro.sortDescriptors = [ordenaPorNome]
        
        gerenciadorDeResultados = NSFetchedResultsController(fetchRequest: recuperaLivro, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try gerenciadorDeResultados?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contadorLivros = gerenciadorDeResultados?.fetchedObjects?.count else {return 0}
        return contadorLivros
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        
        guard let livro = gerenciadorDeResultados?.fetchedObjects![indexPath.row] else {return celula}
        
        celula.titleTextLabel.text = livro.titulo
        celula.subtitleTextLabel.text = livro.autor
        
        return celula
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

}
