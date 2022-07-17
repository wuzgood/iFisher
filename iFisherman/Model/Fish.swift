//
//  Fish.swift
//  iFisherman
//
//  Created by Wuz Good on 07.07.2022.
//

import SwiftUI
import RealmSwift

class Fish: Object, Identifiable {
    
    @Persisted var id = UUID()
    @Persisted var name = ""
    @Persisted var weight = 0.0
    @Persisted var imageName = ""
    @Persisted var date = Date()
    @Persisted var latitude = 0.0
    @Persisted var longitude = 0.0
    @Persisted var info = ""

}
