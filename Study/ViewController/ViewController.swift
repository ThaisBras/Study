//
//  ViewController.swift
//  Study
//
//  Created by Thais da Silva Bras on 19/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    var buttonAdd: UIBarButtonItem?
    var buttonEdit: UIBarButtonItem?
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)]
       
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        title = "Disciplinas"
        
        //Botão de adicionar Disciplinas
        buttonAdd = UIBarButtonItem(image: UIImage(systemName: "add"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(addNewSubject))
        navigationItem.rightBarButtonItem = buttonAdd!
        
        //Botão de Editar
        buttonEdit = UIBarButtonItem(title: "Editar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(edit))
        navigationItem.leftBarButtonItem = buttonEdit!
    }
    
    @objc
    func addNewSubject() {
        print("right bar button action")
    }

    @objc
    func edit() {
        print("left bar button action")
    }
   
}

