//
//  NewFishView.swift
//  iFisherman
//
//  Created by Wuz Good on 07.07.2022.
//

import SwiftUI
import CoreLocation

struct NewFishView: View {
    // MARK: - Properties
    @EnvironmentObject var modelData: DBViewModel
    @StateObject var locationManager = LocationManager()
    @Environment(\.presentationMode) var presentation
    
    @State var showImagePicker: Bool = false
    @State var image: Image? = nil
    @State var capturedImage: UIImage?
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                if modelData.updateObject == nil {
                    fishImageSection
                }
                fishInfoSection
            }
            .navigationTitle("Рыба")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Отмена") {
                        presentation.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if modelData.allValuesSpecified {
                        toolbarAddButton
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .camera) { image in
                    self.image = Image(uiImage: image)
                    self.capturedImage = image
                }
                .ignoresSafeArea()
            }
            .onAppear {
                modelData.setupInitialData()
                locationManager.requestLocation()
            }
            .onDisappear(perform: modelData.deinitData)
        }
    }
    
    private var toolbarAddButton: some View {
        Button(modelData.updateObject == nil ? "Добавить" : "Сохранить") {
            saveToDocumentDirectory()
            if let location = locationManager.location {
                modelData.latitude = location.latitude
                modelData.longitude = location.longitude
            }
            modelData.addData(presentation: presentation)
        }
    }
    
    private var fishImageSection: some View {
        Section {
            image?.resizable()
                .listRowInsets(EdgeInsets())
                .scaledToFit()
            Button {
                self.showImagePicker.toggle()
            } label: {
                Label(image == nil ? "Сделать фото" : "Изменить фото", systemImage: "camera")
            }
        }
    }
    
    private var fishInfoSection: some View {
        Section {
            TextField("Вид", text: $modelData.name)
            HStack {
                TextField("Вес", value: $modelData.weight, formatter: .deci)
                    .keyboardType(.decimalPad)
                Text("кг")
            }
            ZStack {
                TextEditor(text: $modelData.info)
                if modelData.info.isEmpty{
                    HStack {
                        Text("Описание")
                            .foregroundColor(Color(uiColor: .placeholderText))
                        Spacer()
                    }
                }
            }
        }
    }
   
    // MARK: - Methods
    func saveToDocumentDirectory(imageId: String = UUID().uuidString) {
        modelData.imageName = imageId
        if let image = capturedImage, let data = image.jpegData(compressionQuality: 0.8) {
            do {
                let filename = getDocumentsDirectory().appendingPathComponent(imageId)
                try data.write(to: filename, options: [.atomicWrite])
            } catch {
                print("error saving data")
            }
        }
    }

}

// MARK: - Preview
struct NewFishView_Previews: PreviewProvider {
    static var previews: some View {
        NewFishView()
    }
}

