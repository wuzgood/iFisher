//
//  DBViewModel.swift
//  iFisherman
//
//  Created by Wuz Good on 07.07.2022.
//

import SwiftUI
import RealmSwift

class DBViewModel: ObservableObject {
    // data
    @Published var name = "" {
        didSet {
            checkValues()
        }
    }
    @Published var weight = 0.0 {
        didSet {
            checkValues()
        }
    }
    @Published var imageName = ""
    @Published var latitude = 0.0
    @Published var longitude = 0.0
    @Published var info = ""
    @Published var allValuesSpecified = false
    
    @Published var openNewPage = false
    
    // fetched data
    @Published var fishes = [Fish]()
    
    // updating data
    @Published var updateObject: Fish?
    
    init() {
        fetchData()
    }
    
    private func checkValues() {
        let nameSpecified = name.count > 0
        let weightSpecified = weight > 0
        allValuesSpecified = nameSpecified && weightSpecified
    }
    
    // fetching data
    func fetchData() {
        guard let realm = try? Realm() else { return }

        let results = realm.objects(Fish.self)
        
        // displaying results
        self.fishes = results.compactMap { $0 }
    }
    
    // adding new data
    func addData(presentation: Binding<PresentationMode>) {
        
        let fish = Fish()
        fish.name = name
        fish.weight = weight
        fish.imageName = imageName
        fish.longitude = longitude
        fish.latitude = latitude
        fish.info = info
        
        // getting reference
        guard let realm = try? Realm() else { return }
        
        // writing data
        try? realm.write {
            
            guard let availableObject = updateObject else {
                realm.add(fish)
                return
            }
            
            availableObject.name = name
            availableObject.weight = weight
            availableObject.info = info
        }
        
        // updating UI
        fetchData()
        
        // closing view
        presentation.wrappedValue.dismiss()
    }
    
    // deleting data    
    func deleteRow(with indexSet: IndexSet) {
        guard let realm = try? Realm() else { return }

        indexSet.forEach ({ index in
            try! realm.write {
                realm.delete(self.fishes[index])
            }
        })
        
        fetchData()
    }
    
    // setting and clearing data
    func setupInitialData() {
        guard let updateData = updateObject else { return }
        
        name = updateData.name
        weight = updateData.weight
        imageName = updateData.imageName
        info = updateData.info
    }
    
    func deinitData() {
        name = ""
        weight = 0.0
        imageName = ""
        longitude = 0.0
        latitude = 0.0
        info = ""
    }
    
}

