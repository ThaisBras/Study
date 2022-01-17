//
//  ModalFirstScene.swift
//  Study
//
//  Created by Thais da Silva Bras on 21/07/21.
//

import UIKit

class ModalFirstScene: UIViewController {
    
    var buttonSave: UIBarButtonItem?
    var buttonCancel: UIBarButtonItem?
    let textView = UITextField(frame: CGRect(x: 0.0, y: 250.0, width: 400, height: 50.0)) //constraints de altura e largura
    var viewControllerDelegate: ViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        
        //Botão de adicionar Salvar
        buttonSave = UIBarButtonItem(title: "Salvar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = buttonSave!
        
        //Botão de Cancelar
        buttonCancel = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = buttonCancel!
        
        //Título da Disciplina
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label.center = CGPoint(x: 110, y: 230) //constraints de altura e largura
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "Título da disciplina"
        
        self.view.addSubview(label)
        
        label.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        //UITextView
        
        
        textView.textAlignment = NSTextAlignment.justified
        textView.backgroundColor = UIColor.lightGray
        
        //PlaceHolder
        textView.placeholder = "  Exemplo: Matemática"
        textView.textColor = UIColor.lightGray
        
        textView.becomeFirstResponder()
        
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        
        // Use RGB colour
        textView.backgroundColor = #colorLiteral(red: 0.9585992694, green: 0.9529004693, blue: 0.9629796147, alpha: 1)
        
        // Update UITextView font size and colour
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.font = UIFont(name: "Verdana", size: 17)
        
        // Capitalize all characters user types
        textView.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        
        
        // Make UITextView corners rounded
        textView.layer.cornerRadius = 0
        
        // Enable auto-correction and Spellcheck
        textView.autocorrectionType = UITextAutocorrectionType.yes
        textView.spellCheckingType = UITextSpellCheckingType.yes
        // myTextView.autocapitalizationType = UITextAutocapitalizationType.None
        
        
        self.view.addSubview(textView)
        
        textView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    @objc
    func save() {
        guard
            let text = textView.text,
            !text.isEmpty,
            let subject = try? CoreDataStack.shared.createSubject(name: text)
        
        else {
            print("deu ruim") //colocar um alert "não consegui salvar pois não tem texto"
            return
        }
        print(subject)
        viewControllerDelegate?.didRegister()
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    @objc
    func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
