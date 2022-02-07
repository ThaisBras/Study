//
//  SecondViewController .swift
//  Study
//
//  Created by Thais da Silva Bras on 26/07/21.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, NSFetchedResultsControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, ModalSecondSceneDelegate{
    
    var buttonAdd: UIBarButtonItem!
    var buttonEdit: UIBarButtonItem!
    var buttonDelete: UIBarButtonItem!
    private var collectionViewToDo: UICollectionView?
    private var subject: Subject
    private var toDos: [ToDo]
    weak var delegate: ViewControllerDelegate?
    let mulher = UIImageView()
    let frase = UILabel()
    
    
    init (subject: Subject){
        self.subject = subject
        guard let toDos = subject.toDos?.allObjects as? [ToDo]
        else {
            preconditionFailure("O modelo não foi feito corretamente")
        }
        self.toDos = toDos
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            if let s = try CoreDataStack.shared.getEntityById(id: self.subject.objectID) as? Subject{
                self.subject = s
                numeroDeCelulas()
                collectionViewToDo?.reloadData()
                guard let toDos = subject.toDos?.allObjects as? [ToDo]
                else {
                    preconditionFailure("O modelo não foi feito corretamente")
                }
                self.toDos = toDos
            }
        } catch{
            print(error)
        }
        collectionViewToDo?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
        
        view.addSubview(frase)
        view.addSubview(mulher)
     
       
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        title = "Tarefas".localized() //vai ter que ter uma função aqui
        
        //Botão de adicionar Disciplinas
        buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(addNewSubject))
     
        
        buttonDelete = UIBarButtonItem(image: UIImage(systemName: "trash"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(buttonDeleteSubject))
        navigationItem.rightBarButtonItems = [buttonAdd, buttonDelete]
        
        
        //Colection View
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.bounds.width)-32, height: 76)
        
        collectionViewToDo = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionViewToDo else {
            return
        }
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        _ = view.layoutMarginsGuide
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        collectionView.backgroundColor = .clear
        
        //Empty States
        mulher.image = UIImage(named: "mulher")
        mulher.translatesAutoresizingMaskIntoConstraints = false
        frase.text = "Clique em ”+” para criar sua primeira tarefa!".localized()
        
        mulher.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        mulher.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        frase.numberOfLines = 0
        frase.textAlignment = .center
        frase.textColor = .label

        frase.translatesAutoresizingMaskIntoConstraints = false
        frase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
        frase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        frase.topAnchor.constraint(equalTo: mulher.bottomAnchor, constant: 35).isActive = true
        
    }
    
    func updateList() {
        guard let toDos = self.subject.toDos?.allObjects as? [ToDo]
        else {
            preconditionFailure("O modelo não foi feito corretamente")
        }
        self.toDos = toDos
        self.collectionViewToDo?.reloadData()
        numeroDeCelulas()
    }
    
    @objc
    func addNewSubject() {
        let root = ModalSecondScene(subject: subject)
        root.delegate = self
        let vc = UINavigationController(rootViewController: root)
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true)
        delegate?.didRegister()
        
    }
    
    @ objc
    func buttonDeleteSubject(){
        let alert = UIAlertController(title: "", message: "Tem certeza de que deseja apagar esta disciplina?".localized(), preferredStyle: .actionSheet)
                
        let delete = UIAlertAction(title: "Apagar", style: .destructive) { (_) in
            self.dismiss(animated: true, completion: nil)
            _ = try? CoreDataStack.shared.deleteSubject(subject: self.subject)
            self.navigationController?.popViewController(animated: true)
            
        }
        let cancelDelete = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
                
        alert.addAction(delete)
        alert.addAction(cancelDelete)
                
        present(alert, animated: true, completion: nil)
        print("Deletar a disciplina")
        delegate?.didRegister()
    }

    @objc
    func edit() {
        print("left bar button action")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        delegate?.didRegister()
        return toDos.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        
        let object = toDos[indexPath.row]
        
        cell.configure(label: object.name ?? "")
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ThirdViewController(toDos: toDos[indexPath.row], subject: subject), animated: true)
    }
    
    func numeroDeCelulas() {
            if Int(self.toDos.count) > 0 {
                collectionViewToDo?.isHidden = false
                frase.isHidden = true
                mulher.isHidden = true

            } else {
                collectionViewToDo?.isHidden = true
                frase.isHidden = false
                mulher.isHidden = false
            }
        }
}

