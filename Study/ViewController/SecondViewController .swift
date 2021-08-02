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
    private var collectionView: UICollectionView?
    private let subject: Subject
    private var toDos: [ToDo]
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)]
     
       
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        title = "Tarefas" //vai ter que ter uma função aqui
        
        //Botão de adicionar Disciplinas
        buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(addNewSubject))
        navigationItem.rightBarButtonItem = buttonAdd!
        
        //Botão de Editar
        //buttonEdit = UIBarButtonItem(title: "Editar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(edit))
       
        
        //Colection View
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.bounds.width)-32, height: 76)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        let safeArea = view.layoutMarginsGuide
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        collectionView.backgroundColor = .clear
        
    }
    
    func updateList() {
        guard let toDos = self.subject.toDos?.allObjects as? [ToDo]
        else {
            preconditionFailure("O modelo não foi feito corretamente")
        }
        self.toDos = toDos
        self.collectionView?.reloadData()
    }
    
    
    @objc
    func addNewSubject() {
        let root = ModalSecondScene(subject: subject)
        root.delegate = self
                let vc = UINavigationController(rootViewController: root)
                vc.modalPresentationStyle = .automatic
        present(vc, animated: true)
        
    }

    @objc
    func edit() {
        print("left bar button action")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let number = toDos.count
        
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        
        let object = toDos[indexPath.row]
        
        cell.configure(label: object.name ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ThirdViewController(toDos: toDos[indexPath.row]), animated: true)
    }
   
}

