//
//  AreaView.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import SwiftUI
import MapKit

struct AreaView: View {
    @ObservedObject var mapVM = GameViewModel()
    var body: some View {
        Map(position: $mapVM.cameraPosition) {
            UserAnnotation()
            Marker("Warriors", coordinate: mapVM.stadiums.warriors)
            Marker("49ers", coordinate: mapVM.stadiums.fortyniners)
        }
        .mapControls{
            MapUserLocationButton()
            MapPitchToggle()
        }
        .safeAreaInset(edge: .top){
            HStack {
                Button("Nearby NBA Games"){
                    mapVM.cameraPosition = .region(MKCoordinateRegion(center: mapVM.stadiums.warriors, latitudinalMeters: 2500, longitudinalMeters: 2500))
                }
                .font (.subheadline)
                .padding (12)
                .background (.white)
                .padding ()
                .shadow (radius: 10)
                Button("Nearby NFL Games"){
                    mapVM.cameraPosition = .region(MKCoordinateRegion(center: mapVM.stadiums.fortyniners, latitudinalMeters: 2500, longitudinalMeters: 2500))
                }
                .font (.subheadline)
                .padding (12)
                .background (.white)
                .padding ()
                .shadow (radius: 10)
            }
        }
        .onAppear() {
            //Task {await mapVM.searchCity(searchCity: mapVM.searchCity)}
            CLLocationManager().requestWhenInUseAuthorization()
        }
    }
}

#Preview {
    AreaView()
}
