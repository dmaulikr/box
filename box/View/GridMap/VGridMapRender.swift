import UIKit
import MapKit

class VGridMapRender:MKMapView, MKMapViewDelegate
{
    private weak var controller:CGridMap!
    private let span:MKCoordinateSpan
    private var userCoordinate:CLLocationCoordinate2D!
    private let kSpanSize:CLLocationDegrees = 0.01
    
    init(controller:CGridMap)
    {
        span = MKCoordinateSpan(latitudeDelta:kSpanSize, longitudeDelta:kSpanSize)
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isRotateEnabled = false
        isScrollEnabled = true
        isZoomEnabled = true
        isPitchEnabled = false
        mapType = MKMapType.standard
        showsBuildings = true
        showsPointsOfInterest = true
        showsCompass = true
        showsScale = false
        showsTraffic = false
        delegate = self
        showsUserLocation = true
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func centerLocation(locationCoordinate:CLLocationCoordinate2D)
    {
        let region:MKCoordinateRegion = MKCoordinateRegionMake(locationCoordinate, span)
        setRegion(region, animated:true)
    }
    
    //MARK: map delegate
    
    func mapView(_ mapView:MKMapView, viewFor annotation:MKAnnotation) -> MKAnnotationView?
    {
        guard
            
            let modelAnnotation:MGridMapAnnotation = annotation as? MGridMapAnnotation
        
        else
        {
            return nil
        }
        
        var view:MKAnnotationView? = mapView.dequeueReusableAnnotationView(
            withIdentifier:VGridMapRenderPin.reusableIdentifier)
        
        if view == nil
        {
            view = VGridMapRenderPin(annotation:modelAnnotation)
        }
        else
        {
            view!.annotation = modelAnnotation
        }
        
        return view
    }
    
    func mapView(_ mapView:MKMapView, didSelect view:MKAnnotationView)
    {
    }
    
    func mapView(_ mapView:MKMapView, didDeselect view:MKAnnotationView)
    {
    }
}
