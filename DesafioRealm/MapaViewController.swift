//
//  MapaViewController.swift
//  DesafioRealm
//
//  Created by Swift on 19/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController {

    @IBOutlet weak var mapa: MKMapView!
    var paisSelecionado : Pais?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = paisSelecionado?.nome
        
        let zoom = MKCoordinateSpanMake(20.0, 20.0)
        
        let regiao = MKCoordinateRegionMake(CLLocationCoordinate2DMake(CLLocationDegrees(paisSelecionado!.latitude.value!), CLLocationDegrees( paisSelecionado!.longitude.value!)), zoom)
        
        self.mapa.setRegion(regiao, animated: true)
    }

}
