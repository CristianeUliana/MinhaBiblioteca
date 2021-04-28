//
//  TelaPrincipalSnapshot.swift
//  MinhaBibliotecaTests
//
//  Created by Cristiane Goncalves Uliana on 28/04/21.
//  Copyright © 2021 Estudos. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import MinhaBiblioteca

class TelaPrincipalSnapshot: QuickSpec  {

    override func spec() {
        describe("HomeTableViewController") {
            var view: UITableViewController!
            beforeEach {
                view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeTableViewController") as? UITableViewController
                _ = view.view
            }
            it("should have a cool layout") {
                //expect(view) == recordSnapshot()
                expect(view) == snapshot()
            }
        }
    }
}
