//
//import OserioAnalysis2
//import CoreBluetooth
//import Foundation
//
//class SwiftScaleComm : NSObject , CBCentralManagerDelegate , CBPeripheralDelegate {
//    var centralManager : CBCentralManager?
//        var peripheral:CBPeripheral?
//        var characteristic:CBCharacteristic?
//        
//        var analysisObject:AnalysisObject?
////        var analysisObjectSwift:AnalysisObjectSwift?
//        
//        public var statusHandler:((Status?) -> Void)?
//        public var isconnectHandler:((Bool) -> Void)?
//        public var resultHandler:((AnalysisObject) -> Void)?
////        public var resultSwiftHandler:((AnalysisObjectSwift) -> Void)?
//        
//        public override init(){
//        }
//        
//        public func start(){
//            if centralManager == nil {
//                self.centralManager = CBCentralManager(delegate: self, queue: nil, options:[CBCentralManagerOptionShowPowerAlertKey: true])
//                
//            }
//        }
//        
//        public func close(){
//            if centralManager != nil {
//                centralManager?.stopScan()
//                centralManager = nil
//            }
//        }
//        
//        
//        public func centralManagerDidUpdateState(_ central: CBCentralManager) {
//            switch central.state {
//            case CBManagerState.poweredOn:
//                statusHandler?(.POWEREDON)
//                
//                print("藍芽開啟")
//            case CBManagerState.unauthorized:
//                statusHandler?(.UNAUTHORIZED)
//                
//                print("沒有藍芽功能")
//            case CBManagerState.poweredOff:
//                statusHandler?(.POWEREDOFF)
//                guard #available(iOS 13.0, *) else {
//                    
//                    return
//                }
//                print("藍芽關閉")
//            default:
//                statusHandler?(.UNKNOWNSTATE)
//                print("未知狀態")
//            }
//            central.scanForPeripherals(withServices: nil, options: nil)
//        }
//        public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//            //  因為iOS目前不提供藍芽裝置的UUID的獲取，所以在這裡通過藍芽名稱判斷是否是本公司的裝置
//        
//            if peripheral.name == AnalysisObject.getDeviceName() ||
//                peripheral.name == AnalysisObject.getDeviceName2() ||
//                peripheral.name == AnalysisObject.getDeviceName3() ||
//                peripheral.name == AnalysisObject.getDeviceName4() ||
//                peripheral.name == AnalysisObject.getDeviceName5(){
//                AnalysisObject.setCurrentDeviceName(peripheral.name ?? "")
//                central.connect(peripheral, options: nil)
//                self.peripheral = peripheral
//                self.analysisObject = AnalysisObject()
////                self.analysisObjectSwift = AnalysisObjectSwift()
//                
//            }
//            peripheral.delegate = self
//        }
//        public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral){
//            // 設定代理
//            if let name = peripheral.name {
//                print(name)
//                isconnectHandler?(true)
//            }
//            self.peripheral?.delegate = self
//            self.peripheral?.discoverServices(nil)
//    //        peripheral.delegate = self
//    //        // 開始發現服務
//    //        peripheral.discoverServices(nil)
//            // 儲存當前連線裝置
//            central.stopScan()
//            // 這裡可以發通知出去告訴裝置連線介面連線成功
//        }
//        public func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
//            print("didFailToConnect")
//        }
//        public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
//        
//            isconnectHandler?(false)
//            
//        }
//        public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?){
//            if (error != nil){
//                print("尋找 services 時 \(peripheral.name ?? "") 錯誤 \(error?.localizedDescription ?? "")")
//            }
//            for service in peripheral.services! {
//                peripheral.discoverCharacteristics(nil, for: service)
//            }
//        }
//        public func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: Error?) {
//            print("didDiscoverIncludedServicesFor")
//            
//        }
//        public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?){
//            for characteristic in service.characteristics! {
//                if characteristic.uuid.uuidString == AnalysisObject.getSetWriteUuid(){
//                    self.peripheral = peripheral
//                    self.characteristic = characteristic
//                    if AnalysisObject.getAge() > 80 {AnalysisObject.setAge(80)} else if AnalysisObject.getAge() < 10 {AnalysisObject.setAge(10)}
//                    peripheral.writeValue(AnalysisObject.setUserProfile(), for: characteristic, type: .withoutResponse)
//                    
////                    if let data = AnalysisObject.setUserProfile() {
////                        if AnalysisObject.getAge() > 80 {AnalysisObject.setAge(80)} else if AnalysisObject.getAge() < 10 {AnalysisObject.setAge(10)}
////                        peripheral.writeValue(data, for: characteristic, type: .withoutResponse)
////                    }
//                }
//                peripheral.setNotifyValue(true, for: characteristic)
//            }
//        }
//        
//        public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?){
//            if let value = characteristic.value {
//                
//                let bytes = [UInt8](value)
//                print(bytes)
//                let errorCode = analysisObject!.analysisResult(value)
////                let errorCodeSwift = analysisObjectSwift!.analysisResult(data: value)
//                
//                if errorCode == AnalysisOK{
//                    resultHandler?(analysisObject!)
//                    peripheral.writeValue(Command.getDataReceivedOK(), for: self.characteristic!, type: .withoutResponse)
//                }
////                if errorCodeSwift == AnalysisOK{
////                    resultSwiftHandler?(analysisObjectSwift!)
////                }
//                print("errorCode enum \(errorCode)")
////                print(AnalysisErrorCode.init(5))
////                if errorCode == AnalysisErrorCode {
////                    resultHandler?(analysisObject!)
////                    analysisObject = nil
////                    peripheral.writeValue(Data(Command.GetDataReceivedOK()), for: self.characteristic!, type: .withoutResponse)
////                }
//            }
//        }
//        func propertiesString(properties: CBCharacteristicProperties)->(String)!{
//            var propertiesReturn : String = ""
//            
//            if (properties.rawValue & CBCharacteristicProperties.broadcast.rawValue) != 0 {
//                propertiesReturn += "broadcast|"
//            }
//            if (properties.rawValue & CBCharacteristicProperties.read.rawValue) != 0 {
//                propertiesReturn += "read|"
//            }
//            if (properties.rawValue & CBCharacteristicProperties.writeWithoutResponse.rawValue) != 0 {
//                propertiesReturn += "write without response|"
//            }
//            if (properties.rawValue & CBCharacteristicProperties.write.rawValue) != 0 {
//                propertiesReturn += "write|"
//            }
//            if (properties.rawValue & CBCharacteristicProperties.notify.rawValue) != 0 {
//                propertiesReturn += "notify|"
//            }
//            if (properties.rawValue & CBCharacteristicProperties.indicate.rawValue) != 0 {
//                propertiesReturn += "indicate|"
//            }
//            if (properties.rawValue & CBCharacteristicProperties.authenticatedSignedWrites.rawValue) != 0 {
//                propertiesReturn += "authenticated signed writes|"
//            }
//            if (properties.rawValue & CBCharacteristicProperties.extendedProperties.rawValue) != 0 {
//                propertiesReturn += "indicate|"
//            }
//            if (properties.rawValue & CBCharacteristicProperties.notifyEncryptionRequired.rawValue) != 0 {
//                propertiesReturn += "notify encryption required|"
//            }
//            if (properties.rawValue & CBCharacteristicProperties.indicateEncryptionRequired.rawValue) != 0 {
//                propertiesReturn += "indicate encryption required|"
//            }
//            return propertiesReturn
//        }
//        public enum Status{
//            case POWEREDON
//            case UNAUTHORIZED
//            case POWEREDOFF
//            case UNKNOWNSTATE
//        }
//}
