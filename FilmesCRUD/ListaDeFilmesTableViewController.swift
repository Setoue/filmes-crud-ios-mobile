//
//  ListaDeFilmesTableViewController.swift
//  FilmesCRUD
//
//  Created by user213614 on 4/5/22.
//

import UIKit

class ListaDeFilmesTableViewController: UITableViewController {
    
    var listaDeFilmes: [Filme] = []
    var filmes = CrudFilmes()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaDeFilmes = filmes.listar()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaDeFilmes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = listaDeFilmes[indexPath.row].nome
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(detalhesFilmes(_:)))
        cell.addGestureRecognizer(longPress)
        return cell
    }
    
    @objc func detalhesFilmes(_ gesture: UITapGestureRecognizer){
        if gesture.state == .began{
            let viewCell = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: viewCell) else{ return }
            
            let filmes = listaDeFilmes[indexPath.row]
            
            let alerta = UIAlertController(title: listaDeFilmes[indexPath.row].nome, message: "\(listaDeFilmes[indexPath.row].genero!), \(listaDeFilmes[indexPath.row].lancamento!), \(listaDeFilmes[indexPath.row].duracao!), \(listaDeFilmes[indexPath.row].diretor!)", preferredStyle: .alert)
            let cancelar = UIAlertAction(title: "cancelar", style: .cancel)
            
            present(alerta, animated: true)
            alerta.addAction(cancelar)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let filme = CrudFilmes()
            filme.deletar(index: indexPath.row)
            listaDeFilmes = filme.listar()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "segueAdicionar", sender: indexPath.row)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueAdicionar"{
            
            let destinoControlador = segue.destination as! ViewController
            
            guard let i = sender as? Int else{ return }
            destinoControlador.indexFilme = i
            
            
            
        }
    }

}
