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
    weak var deleteDelegate: ThirdViewControllerDelegate?
    
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(TextField.self, forCellReuseIdentifier: "cell")
        return table
    }()
    private var toDos: ToDo
    private var subject: Subject
    private var tasks: [Task]
    
    init (toDos: ToDo, subject: Subject){
        
        self.toDos = toDos
        self.subject = subject
        self.tasks = toDos.tasks?.allObjects as? [Task] ?? []
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
        label.text = "Tarefa".localized()
        
        self.view.addSubview(label)
        
        // Label da Matéria
        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label2.center = CGPoint(x: 120, y: 160) //constraints de altura e largura
        label2.textAlignment = .left
        label2.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label2.font = UIFont.systemFont(ofSize: 22)
        label2.text = "Matéria".localized()
        
        self.view.addSubview(label2)
        
        // Label da Data
        let label3 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label3.center = CGPoint(x: 350, y: 160) //constraints de altura e largura
        label3.textAlignment = .left
        label3.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label3.font = UIFont.systemFont(ofSize: 22)
        label3.text = "Data".localized()
        
        self.view.addSubview(label3)
        
        //Label To Do List
        let label4 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label4.center = CGPoint(x: 120, y: 200) //constraints de altura e largura
        label4.textAlignment = .left
        label4.textColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        label4.font = UIFont.boldSystemFont(ofSize: 22)
        label4.text = "To Do List".localized()
        
        self.view.addSubview(label4)
        
        //TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: view.frame.height/20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height/4.5).isActive = true
        
        label.text = toDos.name
        label2.text = subject.name
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        // Set date format
        dateFormatter.dateFormat = "dd/MM/yyyy"
        label3.text = dateFormatter.string(from: toDos.finishDate!)
        
        // Botão CheckMark
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.tasks[indexPath.row].done ? "✅  " : " ⃝  "
        cell.textLabel?.text = "\(cell.textLabel?.text ?? "") \(self.tasks[indexPath.row].task ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tasks [indexPath.row].done = !self.tasks [indexPath.row].done
        do {
            try CoreDataStack.shared.save()
            
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    @objc
    func edit() {
        
        let alert = UIAlertController(title: "", message: "Tem certeza de que deseja apagar esta tarefa?", preferredStyle: .actionSheet)
        
        let delete = UIAlertAction(title: "Apagar", style: .destructive) { (_) in
            self.dismiss(animated: true, completion: nil)
            //self.deleteDelegate?.didRegister()
            _ = try? CoreDataStack.shared.deleteToDo(toDo: self.toDos)
            self.navigationController?.popViewController(animated: true)
            
        }
        let cancelDelete = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        
        alert.addAction(delete)
        alert.addAction(cancelDelete)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}

