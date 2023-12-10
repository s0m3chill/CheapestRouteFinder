//
//  CheapestRouteMapView.swift
//  CheapestRouteFinder
//
//  Created by Dariy Kordiyak on 09.12.2023.
//

import SwiftUI
import MapKit

final class MapViewCoordinator: NSObject, MKMapViewDelegate {
    
    // MARK: - Properties
    private let parent: CheapestRouteMapView
    
    // MARK: - Initialization
    init(_ parent: CheapestRouteMapView) {
        self.parent = parent
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.pinReuseId.rawValue)
        annotationView.canShowCallout = false
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(overlay: polyline)
            renderer.strokeColor = UIColor(Color.themeColor)
            renderer.lineWidth = LayoutConstants.lineWidth.rawValue
            renderer.lineJoin = .round
            renderer.lineCap = .round
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

struct CheapestRouteMapView: UIViewRepresentable {
    
    // MARK: - Properties
    let cheapestRoute: [Connection]
    private let degreesCenter: CLLocationDegrees = MapConstants.degreesCenter.rawValue
    private let degreesDelta: CLLocationDegrees = MapConstants.degreesDelta.rawValue
    private let zoomDistance: CLLocationDistance = MapConstants.zoomDistance.rawValue
    
    // MARK: - UIViewRepresentable
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = false
        mapView.delegate = context.coordinator
        mapView.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: degreesCenter, longitude: degreesCenter),
            span: MKCoordinateSpan(latitudeDelta: degreesDelta, longitudeDelta: degreesDelta)
        )
        addAnnotationsWithLines(for: mapView)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        addAnnotationsWithLines(for: uiView)
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    // MARK: - Private
    private func addAnnotationsWithLines(for mapView: MKMapView) {
        var polylineCoordinates = cheapestRoute.map { connection in
            return connection.coordinates.from
        }
        for connection in cheapestRoute {
            addAnnotation(for: connection.coordinates.from, for: mapView)
        }
        if let destination = cheapestRoute.last {
            addAnnotation(for: destination.coordinates.to, for: mapView)
            polylineCoordinates.append(destination.coordinates.to)
        }
        let polyline = MKPolyline(coordinates: polylineCoordinates.map { CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.long) },
                                  count: polylineCoordinates.count)
        mapView.addOverlay(polyline)
        
        if let firstPin = cheapestRoute.first?.coordinates.from {
            setInitialVisible(coordinate: firstPin, for: mapView)
        }
    }
    
    private func addAnnotation(for coordinates: Connection.Location, for map: MKMapView) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinates.lat, longitude: coordinates.long)
        map.addAnnotation(annotation)
    }
    
    private func setInitialVisible(coordinate: Connection.Location, for map: MKMapView) {
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.long),
            latitudinalMeters: zoomDistance,
            longitudinalMeters: zoomDistance
        )
        map.setRegion(region, animated: true)
    }
}
