//
//  LivroDao.swift
//  MinhaBiblioteca
//
//  Created by Cristiane Goncalves Uliana on 28/04/21.
//  Copyright © 2021 Estudos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LivroDao: NSObject {
    
    // MARK: - Variáveis
    
    let homeTableViewController = HomeTableViewController()
    var gerenciadorDeResultados:NSFetchedResultsController<Livro>?
    var contexto:NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Métodos
    
    func recuperaLivros() -> [Livro] {
        let recuperaLivro: NSFetchRequest<Livro> = Livro.fetchRequest()
        let ordenaPorNome = NSSortDescriptor(key: "titulo", ascending: true)
        recuperaLivro.sortDescriptors = [ordenaPorNome]
        gerenciadorDeResultados = NSFetchedResultsController(fetchRequest: recuperaLivro, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try gerenciadorDeResultados?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        guard let listaDeLivros = gerenciadorDeResultados?.fetchedObjects else { return [] }
        return listaDeLivros
    }

    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else {return}
            homeTableViewController.tableView.deleteRows(at: [indexPath], with: .fade)
            break
        default:
            homeTableViewController.tableView.reloadData()
        }
    }
    
    
    
    func deletaLivro(_ livro: Livro) {
        
        contexto.delete(livro)
        
        do {
            try contexto.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
}
