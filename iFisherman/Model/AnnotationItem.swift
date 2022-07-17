//
//  AnnotationItem.swift
//  iFisherman
//
//  Created by Wuz Good on 08.07.2022.
//

import CoreLocation

struct AnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}
