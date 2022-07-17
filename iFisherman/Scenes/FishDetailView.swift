//
//  FishDetailView.swift
//  iFisherman
//
//  Created by Wuz Good on 08.07.2022.
//

import SwiftUI
import MapKit

struct FishDetailView: View {
    @State private var isAnimating = false
    @State var fish: Fish
    @State var coordinateRegion = MKCoordinateRegion()
    @State var location: CLLocationCoordinate2D?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if let location = location {
                Map(coordinateRegion: $coordinateRegion,
                    annotationItems: [AnnotationItem(coordinate: location)]) { item in
                    MapMarker(coordinate: item.coordinate)
                }
                    .frame(minWidth: 300, maxWidth: .infinity, minHeight: 250, maxHeight: 300)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(fish.weight.formattedKilograms())
                        .font(.headline)
                        .fontWeight(.light)
                    Spacer()
                    Text(fish.date.formatted(date: .omitted, time: .omitted))
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.secondary)
                }
                
                Text(fish.name)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .scaleEffect(isAnimating ? 1 : 0.7)
            
            loadImage(for: fish)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 500)
                .cornerRadius(10)
                .padding(.horizontal)
                .shadow(radius: 10, x: 1, y: 2)
                .scaleEffect(isAnimating ? 1 : 0.5)
            
            Text(fish.info)
                .fontWeight(.medium)
                .padding()
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(location == nil ? .bottom : .top)
        .onAppear {
            withAnimation {
                isAnimating = true
            }
            if fish.longitude == 0 && fish.latitude == 0 { return }
            location = CLLocationCoordinate2D(latitude: fish.latitude, longitude: fish.longitude)
            guard let location = location else { return }
            coordinateRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        }
    }
    
}

