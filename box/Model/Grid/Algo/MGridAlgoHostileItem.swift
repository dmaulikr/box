import UIKit
import CoreLocation

class MGridAlgoHostileItem:MGridAlgoItem
{
    let level:Int
    private(set) var defeated:Int
    private(set) var credits:Int
    private let kTimeDivisor:TimeInterval = 36000
    private let kDistanceDivisor:CLLocationDistance = 20
    private let kLevelMultiplier:CGFloat = 4
    
    init(
        firebaseId:String,
        latitude:Double,
        longitude:Double,
        level:Int,
        defeated:Int,
        created:TimeInterval)
    {
        self.level = level
        self.defeated = defeated
        credits = 0
        
        super.init(
            firebaseId:firebaseId,
            latitude:latitude,
            longitude:longitude,
            created:created)
    }
    
    override func distanceTo(location:CLLocation, renderReady:Bool)
    {
        super.distanceTo(location:location, renderReady:renderReady)
        
        if renderReady
        {
            updateCredits()
        }
    }
    
    //MARK: private
    
    private func updateCredits()
    {
        guard
            
            let distance:CLLocationDistance = self.distance
            
            else
        {
            return
        }
        
        let credsMultiplier:CGFloat = creditsMultiplier()
        var credits:CGFloat = CGFloat(level) * kLevelMultiplier
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        let deltaTime:TimeInterval = timestamp - created
        let timeDivided:TimeInterval = deltaTime / kTimeDivisor
        let distanceDivided:CLLocationDistance = distance / kDistanceDivisor
        let maxCredits:CGFloat = CGFloat(DEnergy.kMaxEnergy)
        credits += CGFloat(timeDivided)
        credits += CGFloat(distanceDivided)
        credits *= credsMultiplier
        
        if credits > maxCredits
        {
            credits = maxCredits
        }
        
        self.credits = Int(credits)
    }
    
    //MARK: public
    
    func titleMatch() -> String?
    {
        return nil
    }
    
    func creditsMultiplier() -> CGFloat
    {
        return 0
    }
    
    func destroySuccess()
    {
    }
    
    func addDefeated()
    {
        defeated += 1
        
        let path:String = "\(firebasePath())/\(FDbAlgoHostileItem.defeated)"
        FMain.sharedInstance.db.updateChild(
            path:path,
            json:defeated)
    }
}