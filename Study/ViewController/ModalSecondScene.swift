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
    let tableView: UITableView = {
        let table = UITableView()
      table.register(TextField.self, forCellReuseIdentifier: "cell")
      return table
    }()
    
    
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
        label.text = "Título da disciplina"
        
        self.view.addSubview(label)
        
        label.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        //UITextView
        let textView = UITextView(frame: CGRect(x: 0.0, y: 150.0, width: 400, height: 50.0)) //constraints de altura e largura
        
         textView.textAlignment = NSTextAlignment.justified
         textView.backgroundColor = UIColor.lightGray
         
        //PlaceHolder
        textView.text = "Exemplo: Matemática"
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
         
         // Make UITextView web links clickable
         textView.isSelectable = true
         textView.isEditable = false
         textView.dataDetectorTypes = UIDataDetectorTypes.link
         
         // Make UITextView corners rounded
         textView.layer.cornerRadius = 0
         
         // Enable auto-correction and Spellcheck
         textView.autocorrectionType = UITextAutocorrectionType.yes
         textView.spellCheckingType = UITextSpellCheckingType.yes
         // myTextView.autocapitalizationType = UITextAutocapitalizationType.None
         
         // Make UITextView Editable
         textView.isEditable = true
         
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
        let datePicker: UIDatePicker = UIDatePicker()
               
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
        
        //Botão Novo tópico
      
        
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
        
        //Botão Checked/Unchecked
        var buttonChecked: UIButton!
        var buttonUnchecked: UIButton!
        
        buttonChecked.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        buttonUnchecked.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TextField{
            cell.backgroundColor = .clear
            return cell
        }
        return UITableViewCell()
    }
    
    @objc
    func save() {
        print("right bar button action")
    }

    @objc
    func cancel() {
        print("left bar button action")
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
    
    
    
}



