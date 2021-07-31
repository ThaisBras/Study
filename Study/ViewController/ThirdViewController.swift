//
//  ThirdViewController.swift
//  Study
//
//  Created by Thais da Silva Bras on 26/07/21.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var buttonEdit: UIBarButtonItem?
    //var buttonBack: UIBarButtonItem?
    private var toDos: ToDo
    
    init (toDos: ToDo){

        self.toDos = toDos
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
       
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)

        //Botão de adicionar Salvar
        buttonEdit = UIBarButtonItem(title: "Editar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(edit))
        navigationItem.rightBarButtonItem = buttonEdit!
        
        //Botão de Back
       // buttonBack = UIBarButtonItem(title: "Voltar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
        //navigationItem.leftBarButtonItem = buttonBack!

    }

@objc
func edit() {
    print("right bar button action")
}

@objc
func back() {

}

}
