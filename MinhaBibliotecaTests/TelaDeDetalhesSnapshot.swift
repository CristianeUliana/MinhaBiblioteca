//
//  snapShot.swift
//  MinhaBibliotecaTests
//
//  Created by Cristiane Goncalves Uliana on 28/04/21.
//  Copyright © 2021 Estudos. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import MinhaBiblioteca

class TelaDeDetalhesSnapshot: QuickSpec  {

    override func spec() {
        describe("ViewController") {
            var view: ViewController!
            beforeEach {
                view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detalhes") as? ViewController
                _ = view.view
            }
            it("should have a cool layout") {
                //expect(view) == recordSnapshot()
                expect(view) == snapshot()
            }
        }
    }
}
