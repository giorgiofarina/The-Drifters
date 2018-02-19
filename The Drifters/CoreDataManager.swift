//
//  CoreDataManager.swift
//  The Drifters
//
//  Created by Luis Mautone on 16/02/18.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// 1) ritornaLista: riceve nome lista in ingresso e ritorna istanza di List corrispondente

func ritornaLista(nomeLista: String) -> List {
    let request: NSFetchRequest<List> = List.fetchRequest()
    let pred = NSPredicate(format: "listName == %@", nomeLista)
    request.predicate = pred
    let list = try? context.fetch(request)
    if list == nil {
        print("Nessuna lista trovata")
    }
    return list![0]
}

// 2) generaImmagine: riceve pianta in ingresso e ritorna immagine corrispondente
// istanzaPianta: Plant deve essere il risultato di funzioni precedenti (ricercaPerFiltri, mostraLista)
// *** AD ESEMPIO: da ricercaPerFiltri ho un vettore [Plant], i cui campi li metto in ingresso a generaImmagine

func generaImmagine(istanzaPianta: Plant) -> UIImage {
    let image = UIImage(data: (istanzaPianta.img1)! as Data)
    return image!
}

// 3) aggiungiPianta: riceve lista e pianta in ingresso
// *** AD ESEMPIO: da ricercaPerFiltri ho [Plant] i cui campi li metto in ingresso ad aggiungiPianta

func aggiungiPianta(istanzaPianta: Plant, istanzaLista: List) {
    istanzaLista.addToPlants(istanzaPianta)
    appDelegate.saveContext()
}

// 4) rimuoviPianta: riceve lista e pianta in ingresso

func rimuoviPianta(istanzaPianta: Plant, istanzaLista: List) {
    istanzaLista.removeFromPlants(istanzaPianta)
    appDelegate.saveContext()
}

// 5) mostraLista: riceve lista in ingresso e ritorna array di piante in uscita

func mostraLista(istanzaLista: List) -> [Plant] {
    let request: NSFetchRequest<List> = List.fetchRequest()
    let pred = NSPredicate(format: "listName == %@", istanzaLista.listName!)
    request.predicate = pred

    let list = try? context.fetch(request)
    if list == nil {
        print("Nessuna lista trovata")
    }
    return list![0].plants?.allObjects as! [Plant]
}

// 6) aggiungiFiltri: riceve filtro in ingresso e lo aggiunge al dizionario dei filtri contenuto in AppDelegate
// da chiamare ogni volta che si è settato un valore per un filtro
// *** ATTENZIONE *** il nome del filtro deve essere uguale al campo del CoreData Model!!!

func aggiungiFiltri(nomeFiltro: String, valoreFiltro: String) {
    filtri["\(nomeFiltro) == %@"] = valoreFiltro
}

// 7) rimuoviFiltri: riceve nome filtro in ingresso e lo rimuove dal dizionario dei filtri
// da chiamare ogni volta che si è annullato un valore per un filtro

func rimuoviFiltri(nomeFiltro: String) {
    filtri.remove(at: filtri.index(forKey: nomeFiltro)!)
}

// 8) svuotaFiltri: svuota il dizionario dei filtri
// ogni volta che è necessario

func svuotaFiltri() {
    filtri.removeAll()
}

// 9) ricercaPerFiltri: riceve array di filtri in ingresso e ritorna array di piante in uscita

func ricercaPerFiltri(arrayFiltri: [String: String]) -> [Plant] {
    let request: NSFetchRequest<Plant> = Plant.fetchRequest()
    
    if filtri.count == 0 {
        // nessun filtro impostato
        
        let fetchedPlants = try? context.fetch(request)
        
        if fetchedPlants == nil {
            print("Nessuna pianta trovata")
        }
        
        return fetchedPlants!
        
    } else {
        // ricerca per filtri
        
        var predicates = [NSPredicate]()
        
        for ogniFiltro in filtri {
            let newPredicate = NSPredicate(format: ogniFiltro.key, ogniFiltro.value as CVarArg)
            predicates.append(newPredicate)
        }
        
        let pred = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        request.predicate = pred
        let fetchedPlants = try? context.fetch(request)
        
        if fetchedPlants == nil {
            print("Nessuna pianta trovata")
        }
        
        return fetchedPlants!
    }
}

