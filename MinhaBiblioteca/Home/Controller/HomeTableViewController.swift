//
//  HomeTableViewController.swift
//  MinhaBiblioteca
//
//  Created by Cristiane Goncalves Uliana on 22/03/21.
//  Copyright © 2021 Estudos. All rights reserved.
//

import UIKit
import CoreData


class HomeTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    //MARK: - Variáveis
    
    var contexto:NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    var gerenciadorDeResultados:NSFetchedResultsController<Livro>?
    var livroViewController:ViewController?
   
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recuperaLivros()
    }

    
    // MARK: - Métodos
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar" {
            livroViewController = segue.destination as? ViewController
        }
    }
    
    func recuperaLivros() {
        let recuperaLivro: NSFetchRequest<Livro> = Livro.fetchRequest()
        let ordenaPorNome = NSSortDescriptor(key: "titulo", ascending: true)
        recuperaLivro.sortDescriptors = [ordenaPorNome]
        
        gerenciadorDeResultados = NSFetchedResultsController(fetchRequest: recuperaLivro, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        
        gerenciadorDeResultados?.delegate = self
        
        do {
            try gerenciadorDeResultados?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let livroSelecionado = gerenciadorDeResultados?.fetchedObjects![indexPath.row] else {return}
            
            contexto.delete(livroSelecionado)
            
            do {
                try contexto.save()
            } catch {
                print(error.localizedDescription)
            }

        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let livroSelecionado = gerenciadorDeResultados?.fetchedObjects![indexPath.row] else {return}
        livroViewController?.livro = livroSelecionado
    }
    
    
    @objc func mostrarDetalhes(_ longPress:UILongPressGestureRecognizer) {
        if longPress.state == .began {
            
            guard let livro = gerenciadorDeResultados?.fetchedObjects?[(longPress.view?.tag)!] else {return}
            
            let alerta = UIAlertController(title: livro.titulo, message: detalhes(livro), preferredStyle: .alert)
            
            let botaoOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alerta.addAction(botaoOk)
            
            self.present(alerta, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    func detalhes(_ livro: Livro) -> String {
        
        guard let autor = livro.autor else {return ""}
        guard let editora = livro.editora else {return ""}
        guard let ano = livro.ano else {return ""}
        
        let mensagem = "Autor: \(autor) - Editora: \(editora) - Ano: \(ano)"
        
        return mensagem  
    }
    
    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contadorLivros = gerenciadorDeResultados?.fetchedObjects?.count else {return 0}
        return contadorLivros
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        celula.tag = indexPath.row
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_ :)))
        
        guard let livro = gerenciadorDeResultados?.fetchedObjects![indexPath.row] else {return celula}
        
        celula.titleTextLabel.text = livro.titulo
        celula.subtitleTextLabel.text = livro.autor
        celula.addGestureRecognizer(longPress)
        
        return celula
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    // MARK: - FetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .fade)
            break
        default:
            tableView.reloadData()
        }
    }

}
