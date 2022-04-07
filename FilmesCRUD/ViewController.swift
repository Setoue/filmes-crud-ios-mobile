//
//  ViewController.swift
//  FilmesCRUD
//
//  Created by user213614 on 4/5/22.
//

import UIKit

class ViewController: UIViewController {

    var indexFilme: Int = -1
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var nomeTextField: UITextField!
    
    @IBOutlet weak var generoTextField: UITextField!
    
    @IBOutlet weak var diretorTextField: UITextField!
    
    @IBOutlet weak var lancamentoTextField: UITextField!
    
    @IBOutlet weak var duracaoTextField: UITextField!
    
    @IBOutlet weak var botaoTextField: UIButton!
    
    @IBAction func botaoAction(_ sender: Any) {
        
        let filmesO = CrudFilmes()
        if isEdicao() == true {
            filmesO.editar(index: indexFilme, nome: nomeTextField.text!, duracao: duracaoTextField.text!, genero: generoTextField.text!, lancamento: lancamentoTextField.text!, diretor: diretorTextField.text!)
        } else {
            filmesO.salvar(nome: nomeTextField.text!, duracao: duracaoTextField.text!, genero: generoTextField.text!, lancamento: lancamentoTextField.text!, diretor: diretorTextField.text!)
        }
    }
    func isEdicao() -> Bool{
        return ( indexFilme >= 0 ? true : false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (isEdicao()){
            let filmeE = CrudFilmes()
            
            let f = filmeE.listar()
            
            nomeTextField.text = f[indexFilme].nome
            duracaoTextField.text = f[indexFilme].duracao
            lancamentoTextField.text = f[indexFilme].lancamento
            diretorTextField.text = f[indexFilme].diretor
            generoTextField.text = f[indexFilme].genero
            
            
            botaoTextField.setTitle("Editar", for: .normal)
            textLabel.text = "Editar filme"
            
            
        }

        // Do any additional setup after loading the view.
    }


}

