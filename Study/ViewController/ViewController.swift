//
//  ViewController.swift
//  Study
//
//  Created by Thais da Silva Bras on 19/07/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate, ViewControllerDelegate{
    
    var buttonAdd: UIBarButtonItem!
    var buttonEdit: UIBarButtonItem!
    private var collectionView: UICollectionView?
    var subjects: [Subject] = []
    let mulher = UIImageView()
    let frase = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do{
            self.subjects = try CoreDataStack.shared.getSubjects()
            numeroDeCelulas()
            collectionView?.reloadData()
        } catch {
            print(error)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        numeroDeCelulas()
        collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
        
        view.addSubview(frase)
        view.addSubview(mulher)
        
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        title = "Disciplinas"
        
        //Botão de adicionar Disciplinas
        buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(addNewSubject))
        navigationItem.rightBarButtonItem = buttonAdd!
        
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
        
        //Empty States
        mulher.image = UIImage(named: "mulher")
        mulher.translatesAutoresizingMaskIntoConstraints = false
        frase.text = "Clique em ”+” para criar sua primeira disciplina!"
        
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
    
    @objc
    func addNewSubject() {
        let root = ModalFirstScene()
        root.viewControllerDelegate = self
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
        let vc = SecondViewController(subject: self.subjects[indexPath.row])
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didRegister() {
        do{
            self.subjects = try CoreDataStack.shared.getSubjects()
        } catch {
            print(error)
        }
        collectionView?.reloadData()
    }
    
    func numeroDeCelulas(){
            if Int(self.subjects.count) != 0 {
                collectionView?.isHidden = false
                frase.isHidden = true
                mulher.isHidden = true

            } else{
                collectionView?.isHidden = true
                frase.isHidden = false
                mulher.isHidden = false

            }
        }
    
}
 
extension ViewController: AddSubjectsDelegate{
    func addSubjects(subject: Subject) {
        self.dismiss(animated: true){
            self.collectionView?.reloadData()
            self.numeroDeCelulas()
        }
    }
}

