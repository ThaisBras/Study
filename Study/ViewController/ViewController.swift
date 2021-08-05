//
//  ViewController.swift
//  Study
//
//  Created by Thais da Silva Bras on 19/07/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
  
    var buttonAdd: UIBarButtonItem!
    var buttonEdit: UIBarButtonItem!
    private var collectionView: UICollectionView?
    var subjects: [Subject] = []

//    private lazy var frc: NSFetchedResultsController<Subject> = {
//            let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
//            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Subject.name, ascending: false)]
//
//            let frc = NSFetchedResultsController<Subject>(fetchRequest: fetchRequest,
//                                                          managedObjectContext: CoreDataStack.shared.mainContext,
//                                                        sectionNameKeyPath: nil,
//                                                        cacheName: nil)
//            frc.delegate = self
//            return frc
//        }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do{
            self.subjects = try CoreDataStack.shared.getSubjects()
        } catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)]
     
       
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        title = "Disciplinas"
        
        //Botão de adicionar Disciplinas
        buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(addNewSubject))
        navigationItem.rightBarButtonItem = buttonAdd!
        
        //Botão de Editar
        //buttonEdit = UIBarButtonItem(title: "Editar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(edit))
        //navigationItem.leftBarButtonItem = buttonEdit!
        
        //CollectionView
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
        
        _ = view.layoutMarginsGuide
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        collectionView.backgroundColor = .clear
        
//        do {
//            try frc.performFetch()
//        } catch  {
//            print("Falhou Fetch")
//        }
        
      
    }
    
    @objc
    func addNewSubject() {
        let root = ModalFirstScene()
                let vc = UINavigationController(rootViewController: root)
                vc.modalPresentationStyle = .automatic
                present(vc, animated: true)
    }

    @objc
    func edit() {
        print("left bar button action")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let number = self.subjects.count
        
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        
        let object = self.subjects[indexPath.row]
        
        cell.configure(label: object.name ?? "")
        
        return cell
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            switch type {
            case .insert:
                if let newIndexPath = newIndexPath {
                    collectionView?.insertItems(at: [newIndexPath])
                }
            case .delete:
                if let indexPath = indexPath {
                    collectionView?.deleteItems(at: [indexPath])
                }
            default:
                break
            }
            collectionView?.reloadData()
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(SecondViewController(subject: self.subjects[indexPath.row]), animated: true)
    }
}

