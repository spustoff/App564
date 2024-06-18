//
//  PrizesViewModel.swift
//  App564
//
//  Created by DJUROM on 03/06/2024.
//

import SwiftUI
import CoreData

final class PrizesViewModel: ObservableObject {
    
    @Published var photos: [String] = ["surprize", "ball"]
    @Published var currentPhoto = ""
    
    @Published var isAdd: Bool = false
    @Published var isAddPrize: Bool = false
    @Published var isDelete: Bool = false
    @Published var isReset: Bool = false
    @Published var isDetail: Bool = false
    @Published var isMore: Bool = false
    
    @Published var prPhoto = ""
    @Published var prName = ""
    @Published var prDescription = ""
    @Published var prCurGame = ""

    @Published var prizes: [PrizeModel] = []
    @Published var selectedPrize: PrizeModel?
    
    func addPrize() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "PrizeModel", into: context) as! PrizeModel
        
        loan.prPhoto = prPhoto
        loan.prName = prName
        loan.prDescription = prDescription
        loan.prCurGame = prCurGame

        CoreDataStack.shared.saveContext()
    }
    
    func fetchPrizes() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PrizeModel>(entityName: "PrizeModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.prizes = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.prizes = []
        }
    }
}
