//
//  PaisesTableViewController.swift
//  DesafioRealm
//
//  Created by Swift on 19/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit
import RealmSwift

class PaisesTableViewController: UITableViewController {
    
    var arrayGeral : [String : [[String : Any]]] = [:]
    var arrayTable = [Pais]()
    let caminhoArquivo = Bundle.main.url(forResource: "paises", withExtension: "json")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dadosJSON : Data = try! Data(contentsOf: caminhoArquivo!)
        
        do {
            self.arrayGeral = try JSONSerialization.jsonObject(with: dadosJSON, options: JSONSerialization.ReadingOptions.allowFragments) as!  [String : [[String : Any]]]
            print("Leitura do arquivo JSON Ok")
        } catch {
            print("Erro na leitura do arquivo JSON: \(error)")
        }
        
        let realm = try! Realm()
        
        let paises = realm.objects(Pais.self)
        
        if paises == nil || paises.count == 0 {
           
            
            for paisJson in self.arrayGeral["paises"]! {
                var pais = Pais()
                pais.nome = paisJson["name"] as! String
                pais.longitude.value = paisJson["longitude"] as! Float?
                pais.latitude.value = paisJson["latitude"] as! Float?
                try! realm.write {
                    realm.add(pais)
                }
            }
        }
        
        arrayTable.append(contentsOf: realm.objects(Pais.self))
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.arrayTable.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        cell.textLabel?.text = self.arrayTable[indexPath.row].nome
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var paisTabela = self.arrayTable[indexPath.row]
        self.performSegue(withIdentifier: "paisSegue", sender: paisTabela)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let proximaTela = segue.destination as? MapaViewController {
            if let paisSender = sender as? Pais {
                proximaTela.paisSelecionado = paisSender
            }
        }
    }

}
