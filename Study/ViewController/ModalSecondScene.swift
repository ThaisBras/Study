//
//  ModalSecondScene.swift
//  Study
//
//  Created by Thais da Silva Bras on 22/07/21.
//

import UIKit


class ModalSecondScene: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var buttonSave: UIBarButtonItem?
    var buttonCancel: UIBarButtonItem?
    var buttonToDo: UIButton = UIButton ()
    let tableView: UITableView = {
        let table = UITableView()
      table.register(TextField.self, forCellReuseIdentifier: "cell")
      return table
    }()
    let textView = UITextField(frame: CGRect(x: 0.0, y: 150.0, width: 400, height: 50.0)) //constraints de altura e largura
    let datePicker: UIDatePicker = UIDatePicker()
    let textViewToDo = UITextField(frame: CGRect(x: 0.0, y: 340.0, width: 280, height: 50.0))
    var subject: Subject
    weak var delegate: ModalSecondSceneDelegate?
    var tasks: [String] = []
    var delegateSegundo: AddToDosDelegate?
    
    init (subject: Subject){
        self.subject = subject
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
        buttonSave = UIBarButtonItem(title: "Salvar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = buttonSave!
        
        //Botão de Cancelar
        buttonCancel = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = buttonCancel!
        
        //Título da Disciplina
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label.center = CGPoint(x: 110, y: 130) //constraints de altura e largura
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "Título da tarefa"
        
        self.view.addSubview(label)
        
        label.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        //UITextView
         textView.textAlignment = NSTextAlignment.justified
         textView.backgroundColor = UIColor.lightGray
         
        //PlaceHolder
        textView.placeholder = "  Exemplo: Prova 1"
      
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
        
        //Data
        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label2.center = CGPoint(x: 110, y: 230) //constraints de altura e largura
        label2.textAlignment = .left
        label2.textColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        label2.font = UIFont.boldSystemFont(ofSize: 22)
        label2.text = "Data"
        
        self.view.addSubview(label2)
        
        label2.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        label2.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        label2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        label2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        // DatePicker
        // Posição
        datePicker.frame = CGRect(x: 90, y: 250, width: self.view.frame.width, height: 30)
        
        // Propriedades
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
               
        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(self, action: #selector(ModalSecondScene.datePickerValueChanged(_:)), for: .valueChanged)
          
        // Add DataPicker to the view
        self.view.addSubview(datePicker)
        
        //To Do List
        let label3 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label3.center = CGPoint(x: 110, y: 320) //constraints de altura e largura
        label3.textAlignment = .left
        label3.textColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        label3.font = UIFont.boldSystemFont(ofSize: 22)
        label3.text = "To Do List"
        
        self.view.addSubview(label3)
        
        label3.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        label3.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        label3.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        label3.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        //TextView ToDo
        textViewToDo.textAlignment = NSTextAlignment.justified
        textViewToDo.backgroundColor = UIColor.lightGray
        
       //PlaceHolder
       textViewToDo.placeholder = "  Exemplo: Fazer exercícios"
     
       textViewToDo.becomeFirstResponder()

       textViewToDo.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        
        // Use RGB colour
        textViewToDo.backgroundColor = #colorLiteral(red: 0.9585992694, green: 0.9529004693, blue: 0.9629796147, alpha: 1)
       
        // Update UITextView font size and colour
        textViewToDo.font = UIFont.systemFont(ofSize: 20)
        textViewToDo.textColor = UIColor.black
        
        textViewToDo.font = UIFont.boldSystemFont(ofSize: 20)
        textViewToDo.font = UIFont(name: "Verdana", size: 17)
        
        // Capitalize all characters user types
        textViewToDo.autocapitalizationType = UITextAutocapitalizationType.allCharacters
      
        // Make UITextView corners rounded
        textViewToDo.layer.cornerRadius = 0
        
        // Enable auto-correction and Spellcheck
        textViewToDo.autocorrectionType = UITextAutocorrectionType.yes
        textViewToDo.spellCheckingType = UITextSpellCheckingType.yes
        
        self.view.addSubview(textViewToDo)
        
        //Botão toDo
        buttonToDo.frame = CGRect(x: 280.0, y: 315.0, width: 100.0, height: 100.0)
        buttonToDo.setImage(UIImage(systemName: "plus"), for: .normal)
        buttonToDo.addTarget(self, action: #selector(newToDo), for: .touchUpInside)
        buttonToDo.tintColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        
        self.view.addSubview(buttonToDo)

        //TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
                
        tableView.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: view.frame.height/10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height/4.5).isActive = true
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.tasks [indexPath.row]
        return cell
        
    }
    
    @objc
    func save() {
    
        guard
            let text = textView.text,
            !text.isEmpty,
            let toDo = try? CoreDataStack.shared.createToDo(name: text, date: datePicker.date, subject: subject, tasks: tasks)
        else{
            return
        }
        delegate?.updateList()
        delegateSegundo?.addToDos()
        self.dismiss(animated: true, completion: nil)
       
        
    }

    @objc
    func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func datePickerValueChanged(_ sender: UIDatePicker){
          
    // Create date formatter
    let dateFormatter: DateFormatter = DateFormatter()
          
    // Set date format
    dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
          
    // Apply date format
    let selectedDate: String = dateFormatter.string(from: sender.date)
          
    print("Selected value \(selectedDate)")
      }
      
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
      }
    
    @objc
    func buttonAction(sender: UIButton!) {
      print("Button tapped")
    }
    
    @objc
    func newTopic() {
        print("New Topic tapped")
    }
    
    @objc
    func newToDo(sender: UIButton!){
        guard let t = textViewToDo.text else{
            return
        }
        self.tasks.append(t)
        textViewToDo.text = ""
        tableView.reloadData()
    }
    
}



