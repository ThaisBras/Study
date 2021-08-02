//
//  ThirdViewController.swift
//  Study
//
//  Created by Thais da Silva Bras on 26/07/21.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var buttonEdit: UIBarButtonItem?
    var buttonCheckedImage: UIBarButtonItem!
    var buttonUncheckedImage: UIBarButtonItem!
    
    let tableView: UITableView = {
        let table = UITableView()
      table.register(TextField.self, forCellReuseIdentifier: "cell")
      return table
    }()
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
        buttonEdit = UIBarButtonItem(title: "Apagar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(edit))
        navigationItem.rightBarButtonItem = buttonEdit!
        
        // Label da Tarefa
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label.center = CGPoint(x: 120, y: 135) //constraints de altura e largura
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = "Tarefa"
        
        self.view.addSubview(label)
        
        // Label da Matéria
        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label2.center = CGPoint(x: 120, y: 160) //constraints de altura e largura
        label2.textAlignment = .left
        label2.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label2.font = UIFont.systemFont(ofSize: 22)
        label2.text = "Matéria"
        
        self.view.addSubview(label2)
        
        // Label da Data
        let label3 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label3.center = CGPoint(x: 350, y: 160) //constraints de altura e largura
        label3.textAlignment = .left
        label3.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label3.font = UIFont.systemFont(ofSize: 22)
        label3.text = "Data"
        
        self.view.addSubview(label3)
        
        //Label To Do List
        let label4 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label4.center = CGPoint(x: 120, y: 200) //constraints de altura e largura
        label4.textAlignment = .left
        label4.textColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        label4.font = UIFont.boldSystemFont(ofSize: 22)
        label4.text = "To Do List"
        
        self.view.addSubview(label4)
    
        //TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
                
        tableView.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: view.frame.height/50).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height/4.5).isActive = true
        
        // Botão CheckMark
       

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TextField{
            cell.backgroundColor = .clear
            return cell
        }
        return UITableViewCell()
    }
    

@objc
func edit() {
    print("right bar button action")
}


}
