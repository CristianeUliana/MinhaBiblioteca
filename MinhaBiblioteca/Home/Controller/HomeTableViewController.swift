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
    
    // MARK: - Variáveis
    
    var livroViewController: ViewController?
    var livroDao = LivroDao()
    var lista: [Livro] = []
   
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lista = livroDao.recuperaLivros()
    }

    
    // MARK: - Métodos
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar" {
            livroViewController = segue.destination as? ViewController
        }
    }
    
    @objc func mostrarDetalhes(_ longPress:UILongPressGestureRecognizer) {
        if longPress.state == .began {
            let livro = lista[(longPress.view?.tag)!]
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
    
    // MARK: - tableView

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let contadorLivros = lista.count
        return contadorLivros
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        celula.tag = indexPath.row
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_ :)))
        let livro = lista[indexPath.row]
        celula.configuraCelula(livro)
        celula.addGestureRecognizer(longPress)
        return celula
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let livroSelecionado = lista[indexPath.row]
        livroViewController?.livro = livroSelecionado
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let livroSelecionado = lista[indexPath.row]
            livroDao.deletaLivro(livroSelecionado)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}



