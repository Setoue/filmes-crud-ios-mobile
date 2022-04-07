//
//  CRUDFilmes.swift
//  FilmesCRUD
//
//  Created by user213614 on 4/5/22.
//


import UIKit
import CoreData

class CrudFilmes: UITableViewController{
    
    func listar() -> [Filme] {
            
        var listaFilmes: [Filme] = []
        
                let context = getContext()
        
                //MARK: -LEitura de dados
                let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "FilmesCRUD")
        
                do{
                    let filmeConsulta = try context.fetch(requisicao)
        
                    for t in filmeConsulta as! [NSManagedObject]{
                     
                        
                        let tm = Filme()
                        tm.nome = t.value(forKey: "nome") as! String
                        tm.diretor =  t.value(forKey: "diretor") as! String
                        tm.genero = t.value(forKey: "genero") as! String
                        tm.duracao = t.value(forKey: "duracao") as! String
                        tm.lancamento = t.value(forKey: "lancamento") as! String
                        listaFilmes.append(tm)
        
        
                    }
                }catch{
                    print("Erro ao consultar tarefas")
        }
        return listaFilmes
    }
    //MARK: - Gravar dados
    func salvar(nome: String, duracao: String, genero: String, lancamento: String, diretor: String){
        
        let context = getContext()
        
        let filme = NSEntityDescription.insertNewObject(forEntityName: "FilmesCRUD", into: context)
        
        filme.setValue(nome, forKey: "nome")
        filme.setValue(duracao, forKey: "duracao")
        filme.setValue(genero, forKey: "genero")
        filme.setValue(diretor,forKey: "diretor")
        filme.setValue(lancamento, forKey: "lancamento")
        
        do{
            try context.save()
        }catch{ //so executa o q ta no catch caso o do nao der certo
            print("Erro ao salvar a filme")
        }
    }
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext
        
        return context
    }
    //MARK: -Deletar dados
    func deletar(index: Int) {
        let context = getContext()
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "FilmesCRUD")
        
        do{
            //buscar todos os registros do core data do tipo NSManagedObject
            let filmesConsuta = try context.fetch(requisicao) as! [NSManagedObject]
            
            //deletar do contexto apenas o  registro com o indece do parametro (array definido na linha anterior)
            try context.delete(filmesConsuta[index])
            
            //atualiza o contexto
            try context.save()
        }catch{
            print("Ërro ao remover filme")
        }

        
    }
    //MARK: - Editar dados
    func editar(index: Int, nome: String, duracao: String, genero: String, lancamento: String, diretor: String){
        let context = getContext()
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "FilmesCRUD")
        
        do{
            //buscar todos os registros do core data do tipo NSManagedObject
            let filmesConsuta = try context.fetch(requisicao) as! [NSManagedObject]
            
            //editar apenas o registro com o indice que de desejo da edicao (altera apenas o atributo em questao)
            filmesConsuta[index].setValue(nome, forKey: "nome")
            filmesConsuta[index].setValue(diretor, forKey: "diretor")
            filmesConsuta[index].setValue(lancamento, forKey: "lancamento")
            filmesConsuta[index].setValue(duracao, forKey: "duracao")
            filmesConsuta[index].setValue(genero, forKey: "genero")
            
            //atualiza o contexto
            try context.save()
        }catch{
            print("Ërro ao editar filme")
        }
    }
}
