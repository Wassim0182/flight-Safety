//
//  Manual_ViewController.swift
//  At Training
//
//  Created by WASSIM LAGNAOUI on 2/22/20.
//  Copyright © 2020 WASSIM LAGNAOUI. All rights reserved.
//

import UIKit

class Manual_ViewController: UIViewController {

    // variables
    var valueReceived: Float = 40
    
    // outlets
    
    @IBOutlet weak var visibilityLabel: UILabel!
    
    @IBOutlet weak var ceilingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        
    }//viewdidload()
    
    @IBAction func visibilitySlider(_ sender: UISlider) {
        let temp = sender.value
              let temp1 = temp*4
              let temp2 = roundf(temp1)
              let temp3 = temp2/4
              
              let tempS = String(temp3)
              visibilityLabel.text = tempS
        
        
    }
    
    
    @IBAction func ceilingSlider(_ sender: UISlider) {
             let temp = sender.value
             let tempI = Int(temp)
             let tempS = String(Int(temp))
             ceilingLabel.text = tempS
          
    }
      
    
    
    
   //
    @IBAction func InitiatePressed(_ sender: UIButton) {
       
        //the following needs to run constantly in a loop as long as Manual Training is in progress
        let temp1 = db.integer(forKey: "Max_Pitch")
        print("Pitch Max from Safety Setting: \(temp1)")
        
        let temp2 = db.integer(forKey: "Min_Pitch")
        print("Pitch Min from SS: \(temp2)")
        
//        if valueReceived > Float(temp1) {
//            print("Flip the visor")
//        }
        
        DispatchQueue.global(qos: .background).async {
               
                                         //create an instance of Objective C class
                                         let instanceOfparser: parser = parser()
                                          //declare variables for use with printing or database comparisons
                                          var swiftGPS_Lat: Float? = Optional.none
                                          var swiftGPS_Long:Float? = Optional.none
                                          var swiftGround_speed:CInt? = Optional.none
                                          var swiftGPS_VSI:CShort? = Optional.none
                                          //var swiftGPS_heading:CInt? //Use Yaw value for heading instead of this
                                          var swiftGeo_Altitude:CInt? = Optional.none
                                          var swiftMSL_Altitude:CInt? = Optional.none
                                          var swiftFirmware_version:Float? = Optional.none
                                          var swiftBattPct:CInt? = Optional.none
                                          var swiftRoll:Float? = Optional.none
                                          var swiftPitch:Float? = Optional.none
                                          var swiftYaw:Float? = Optional.none //yaw = Heading
                                          var swiftAirspeedKnots:CInt? = Optional.none
                                          //var swiftAltitudeFeet:CInt? //use Geo Altitude instead of this
                                          var swiftVsiFtPerMin:CInt? = Optional.none
                                          
                                          //creation of while loop for receiving UDP packets
                                          var noOfIterations = 10000
                                   while noOfIterations > 1{
                                       //PROBLEM HERE. THIS IS ONLY PRINTING PITCH AND ROLL ONCE. MAY BE BECAUSE ALTERING THE PROEPRTY VALUE OF AN OBJECT IS NOT ALLOWED. EDIT: it was solved through closing of socket at the end of msgReceiver() function in parser.m file.
                                           //print("inside while loop")
                                           instanceOfparser.msgReceiver() // do this as long as app is actively running
                                           //try setting instanceOfparser.pitch value to be new 'instanceOfparser.pitch' here.
                                           
                                           //printing ObjectiveC properties value for test
                                           //print("myPitch:\(instanceOfparser.pitch)") //test
                                           //print("myRoll:\(instanceOfparser.roll)") //test
                                           
                                           //setting ObjectiveC property values to swift variables for usage with database and application.
                                           //Instead of print function, you can call a comparing method on the swift variables
                                           swiftGPS_Lat = instanceOfparser.gps_Lat
                                           if (swiftGPS_Lat == nil){
                                               //do nothing
                                           }else{
                                               print("Lat = \(swiftGPS_Lat!)")
                                               //call caliberation display function
                                               //call comparing function to database values
                                           }
                                           swiftGPS_Long = instanceOfparser.gps_Long
                                           if (swiftGPS_Long == nil){
                                               //do nothing
                                           }else{
                                               print("Long = \(swiftGPS_Long!)")
                                           }
                                           swiftGround_speed = instanceOfparser.ground_speed
                                           if (swiftGround_speed == nil || swiftGround_speed == 4095){
                                               //do nothing
                                           }else{
                                               print("Ownship 0x0A Horizontal Velocity = \(swiftGround_speed!)")//this is displayed as Ground Speed under GPS section in iLevil AHRS Utility App
                                           }
                                           swiftGPS_VSI = instanceOfparser.gps_VSI
                                           if (swiftGPS_VSI == nil){
                                               //do nothing
                                           }else{
                                               print("Ownship 0x0A Vertical Velocity = \(swiftGPS_VSI!)") //This is displayed as VSI under GPS section in iLevil AHRS Utility App
                                           }
                                           /* swiftGPS_heading = instanceOfparser.gps_heading //USE YAW VALUE FOR HEADING. DO NOT USE GPS HEADING.
                                           if swiftGPS_heading != nil {
                                               print("Heading =\(String(describing: swiftGPS_heading))")
                                           }*/
                                           swiftGeo_Altitude = instanceOfparser.geo_Altitude
                                           if (swiftGeo_Altitude == nil || swiftGeo_Altitude == 0){
                                               //do nothing
                                           }else{
                                               print("Geo Altitude = \(swiftGeo_Altitude!)")
                                           }
                                           
                                           swiftMSL_Altitude = instanceOfparser.mslAltitude                    //newly added for mslAltitude
                                           if(swiftMSL_Altitude == nil || swiftMSL_Altitude == 0 || swiftMSL_Altitude == 4095 || swiftMSL_Altitude == 20475)
                                           {
                                               //do nothing
                                           }else{
                                               print("MSL Altitude = \(swiftMSL_Altitude!)")
                                           }
                                           
                                           
                                           swiftFirmware_version = instanceOfparser.firmware_version
                                           if (swiftFirmware_version == nil || swiftFirmware_version == 0.0){
                                               //do nothing
                                           }else{
                                               print("Firmware Version = \(swiftFirmware_version!)")
                                           }
                                           swiftBattPct = instanceOfparser.battPct
                                           if (swiftBattPct == nil || swiftBattPct == 0){
                                               //do nothing
                                           }else{
                                               print("Battery Percentage = \(swiftBattPct!)")
                                           }
                                       
                                       
                                       
                                           //1. Bring Roll from iLevil
                                           //2. Bring Roll from Database
                                           //3. Compare these two
                                           //(optional) Test Print what to do based on comparison results
                                           //4. Call the emergencyMsgSender() if Roll exceeds limits
                                           swiftRoll = instanceOfparser.roll
                                           if (swiftRoll == nil){
                                               //do nothing
                                           }else
                                           {
                                               print("Roll = \(swiftRoll!)")
                                               let tempF = swiftRoll! //is this a Float?
                                               let tempS = Float(tempF) //if tempF is already a float, we do not need tempS
                                               DispatchQueue.main.async
                                               {
                                                   self.valueReceived = tempS
                                                   //the following needs to run constantly in a loop as long as Manual Training is in progress
                                                   let temp1 = db.integer(forKey: "Max_Roll")
                                                   print("Pitch Max from Safety Setting: \(temp1)")
                                                   
                                                   let temp2 = db.integer(forKey: "Min_Roll")
                                                   print("Pitch Min from Safety Setting: \(temp2)")
                                                   
                                                   if self.valueReceived > Float(temp1)
                                                   {
                                                       print("Flip the visor")
                                                       //send a string to microcontroller
                                                       instanceOfparser.msgForMicrocontroller = 0x45
                                                       instanceOfparser.msgSender()
                                                       
                                                       
                                                       /* //the following will be a better method once array type for emergencyFlipUp[] is figured out. It has to be an array whose each cell holds 8 bits.
                                                       //create a dedicated emergency signal object
                                                       let msgForMicroInstanceOfParser: parser = parser()
                                                       //fill the emergencyFlipUp property with emergency signal code. ASCI '922'
                                                       msgForMicroInstanceOfParser.emergencyFlipUp[0] = 0x39
                                                       msgForMicroInstanceOfParser.emergencyFlipUp[1] = 0x32
                                                       msgForMicroInstanceOfParser.emergencyFlipUp[2] = 0x32
                                                       
                                                       msgForMicroInstanceOfParser.emergencyMsgSender()
                                                       */
                                                   }else{
                                                    print("Do not Flip the visor")
                                                }
                                                   
                                               }
                                           }//else for Roll check
                                              
                                               
                                               
                                               
                                               
                                           swiftPitch = instanceOfparser.pitch
                                           if (swiftPitch == nil){
                                               //do nothing
                                           }else{
                                            print("Pitch = \(swiftPitch!)")
                                            let tempF = swiftPitch! //is this a Float?
                                            let tempS = Float(tempF) //if tempF is already a float, we do not need tempS
                                            DispatchQueue.main.async
                                                {
                                                    self.valueReceived = tempS
                                                    //the following needs to run constantly in a loop as long as Manual Training is in progress
                                                    let temp1 = db.integer(forKey: "Max_Pitch")
                                                    print("Pitch Max from Safety Setting: \(temp1)")
                                                    
                                                    let temp2 = db.integer(forKey: "Min_Pitch")
                                                    print("Pitch Min from Safety Setting: \(temp2)")
                                                    
                                                    if self.valueReceived > Float(temp1)
                                                    {
                                                        print("Flip the visor")
                                                        //send a string to microcontroller
                                                        instanceOfparser.msgForMicrocontroller = 0x45
                                                        instanceOfparser.msgSender()
                                                        
                                                        
                                                        /* //the following will be a better method once array type for emergencyFlipUp[] is figured out. It has to be an array whose each cell holds 8 bits.
                                                         //create a dedicated emergency signal object
                                                         let msgForMicroInstanceOfParser: parser = parser()
                                                         //fill the emergencyFlipUp property with emergency signal code. ASCI '922'
                                                         msgForMicroInstanceOfParser.emergencyFlipUp[0] = 0x39
                                                         msgForMicroInstanceOfParser.emergencyFlipUp[1] = 0x32
                                                         msgForMicroInstanceOfParser.emergencyFlipUp[2] = 0x32
                                                         
                                                         msgForMicroInstanceOfParser.emergencyMsgSender()
                                                         */
                                                    }else{
                                                        print("Do not Flip the visor")
                                                    }
                                                    
                                            }
                                            
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                           swiftYaw = instanceOfparser.yaw
                                           if (swiftYaw == nil){
                                               //do nothing
                                           }else{
                                               print("Heading/Yaw = \(swiftYaw!)")
                                           }
                                           swiftAirspeedKnots = instanceOfparser.airspeedKnots
                                           if (swiftAirspeedKnots == nil || swiftAirspeedKnots == 32767){
                                               //do nothing
                                           }else{
                                               print("iLevil AirSpeed (Knots) = \(swiftAirspeedKnots!)")
                                           }
                                          /* swiftAltitudeFeet = instanceOfparser.altitudeFeet //USE GEO ALTITUDE INSTEAD. ILEVIL SAID NOT TO USE THIS ONE
                                           if swiftAltitudeFeet != nil {
                                                          print("Altitude (Feet) =\(String(describing: swiftAltitudeFeet))")
                                                      } */
                                           swiftVsiFtPerMin = instanceOfparser.vsiFtPerMin
                                           if (swiftVsiFtPerMin == nil || swiftVsiFtPerMin == 32767){
                                               //do nothing
                                           }else{
                                               print("iLevil Vertical Speed(ft per min) = \(swiftVsiFtPerMin!)")
                                           }
                                           /* TWO ways of sending a set of bytes will be:
                                            
                                            1. make 'msgForMicrocontroller' an array of bytes. Append bytes to it in each of above if conditions based on comparison with database. When everything is appended, come here to only call msgSender() on the instanceOfparser.
                                            2. Annoher way could be to create an appender function in parser class. Also, create an array of bytes in parser class. This appender function will append some bytes to array of bytes in each of above IF-ELSE conditions based on the comparisons with database values. Once all the bytes have have been appended, that array (if needed, will be copied into another array of bytes and) will be sent to microcontroller. see sendto() function definition for details on the requirement of (const void*) as the type of array which is to be sent using sendto() function. */
                                         //  instanceOfparser.msgForMicrocontroller = 0x45
                                         //  instanceOfparser.msgSender()
                                       
                                       
                                       
                                           /* The following function DEFINITION can be used whenever the emergency signal is to be sent. Just copy paste the definition of function or reference it for future use.
                                            The following function name is for the event when System Test Button is pressed and it sends flip up signal to visor.
                                            @IBAction func systemTestPressed(_ sender: UIButton) {
                                                print("System Test Button Pressed!\n")
                                                //create a dedicated emergency signal object
                                                let msgForMicroInstanceOfParser: parser = parser()
                                                //fill the emergencyFlipUp property with emergency signal code. ASCI '922'
                                                msgForMicroInstanceOfParser.emergencyFlipUp[0] = 0x39
                                                msgForMicroInstanceOfParser.emergencyFlipUp[1] = 0x32
                                                msgForMicroInstanceOfParser.emergencyFlipUp[2] = 0x32
                                                
                                                msgForMicroInstanceOfParser.emergencyMsgSender()
                                                
                                                
                                            }
                                            */
                                           noOfIterations -= 1
                                       }//while
           
           }
     
        
    }
  

}
