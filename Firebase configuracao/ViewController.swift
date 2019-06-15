//
//  ViewController.swift
//  Firebase configuracao
//
//  Created by Luis Fernando Pasquinelli Amaral de Abreu on 14/03/2018.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var textoLabel: UILabel!
    
    let firebase = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        do {
            try Auth.auth().signOut()
        } catch  {
            print("Erro ao deslogar o usuario")
        }
        */
        
        Auth.auth().signIn(withEmail: "luispasquinelli@hotmail.com", password: "123456") { (usuario, erro) in
            if erro == nil{
                print("sucesso ao logar o usuario")
            } else {
                print("erro ao logar usuario: \(erro?.localizedDescription)")
            }
        }
 
        Auth.auth().addStateDidChangeListener { (Auth, usuario) in
            
            if let usuarioLogado = usuario {
                print("usuario esta logado. email:" + String(describing: usuarioLogado.email))
            } else {
                print("usuario nao esta logado")
            }
        }
        
        /*
        Auth.auth().createUser(withEmail: "luispasquinelli@hotmail.com", password: "123456") { (usuario, erro) in
       
            if erro == nil{
                print("sucesso ao cadastrar o usuario")
            } else {
                print("erro ao cadastrar usuario: \(erro?.localizedDescription)")
            }
        }
        */
 
        let pontuacao = firebase.child("pontuacao").child("valor")
        //pontuacao.removeValue()
        // pontuacao.child("003").child("nome").setValue("Luis")
        //pontuacao.child("valor").setValue("100")
        
        //Recuperar dados do firebase
        pontuacao.observe(DataEventType.value, with: {(dados) in
            let ponto = dados.value as! String
            self.textoLabel.text = ponto
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

