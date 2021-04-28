//
//  HomeTableViewCell.swift
//  MinhaBiblioteca
//
//  Created by Cristiane Goncalves Uliana on 22/03/21.
//  Copyright © 2021 Estudos. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var subtitleTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configuraCelula(_ livro: Livro) {
        titleTextLabel.text = livro.titulo
        subtitleTextLabel.text = livro.autor
    }
}
