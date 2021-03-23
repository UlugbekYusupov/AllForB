//
//  QRScannerController.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/11.
//

import UIKit
import AVFoundation

class QRScannerController : UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var mainPageController: MainPageController?
    var qrCodeFrameView: UIView?
    var qrString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)

        guard let captureDevice = deviceDiscoverySession.devices.first else {
            failed()
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)

            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)

            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]


            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer?.videoGravity = AVLayerVideoGravity.resize
            previewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(previewLayer!)
            captureSession.startRunning()

            qrCodeFrameView = UIView()

            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = mainColor.cgColor
                qrCodeFrameView.layer.borderWidth = 5
                view.addSubview(qrCodeFrameView)
                view.bringSubviewToFront(qrCodeFrameView)
            }

        } catch {
            print(error)
            return
        }
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (captureSession.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (captureSession.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            
            if readableObject.type == AVMetadataObject.ObjectType.qr {
                let barCodeObject = previewLayer.transformedMetadataObject(for: metadataObject)
                qrCodeFrameView?.frame = barCodeObject!.bounds
            }
            
            guard let stringValue = readableObject.stringValue else { return }
            
            qrString = stringValue
//            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(stringCode: stringValue)
        }
    }

    func found(stringCode: String) {
        
        APIService.shared.qrCodeCheck(userId: 1, companyId: 1, qrCode: qrString) { [self] (result, err) in
            if let error = err {
                print(error)
                return
            }
            if let result = result {
                if result["ReturnCode"] as! Int == 0 {
                    captureSession.stopRunning()
                    sleep(5)
                    Vibration.success.vibrate()
                    captureSession.startRunning()
                    DispatchQueue.main.async {
                        qrCodeFrameView?.removeFromSuperview()
                    }
                    print("Success")
                }
                else {
                    captureSession.startRunning()
                    sleep(5)
                    Vibration.error.vibrate()
                    captureSession.stopRunning()
                    DispatchQueue.main.async {
                        qrCodeFrameView?.removeFromSuperview()
                    }
                    print(result["ExceptionMessage"] as! String)
                }
            }
        }
        captureSession.startRunning()
    }
}
//class QRScannerController: UIViewController {
//
//    var captureSession = AVCaptureSession()
//    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
//    var qrCodeFrameView: UIView?
//    var mainPageController: MainPageController?
//
//    var flag: Bool?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .front)
////
//        guard let captureDevice = deviceDiscoverySession.devices.first else {
//            print("Failed to get the camera device")
//            return
//        }
//
//        do {
//            let input = try AVCaptureDeviceInput(device: captureDevice)
//            captureSession.addInput(input)
//
//            let captureMetadataOutput = AVCaptureMetadataOutput()
//            captureSession.addOutput(captureMetadataOutput)
//
//            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
//
//
//            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resize
//            videoPreviewLayer?.frame = view.layer.bounds
//
//
//            view.layer.addSublayer(videoPreviewLayer!)
//            captureSession.startRunning()
//
//            qrCodeFrameView = UIView()
//
//            if let qrCodeFrameView = qrCodeFrameView {
//                qrCodeFrameView.layer.borderColor = mainColor.cgColor
//                qrCodeFrameView.layer.borderWidth = 5
//                view.addSubview(qrCodeFrameView)
//                view.bringSubviewToFront(qrCodeFrameView)
//            }
//
//        } catch {
//            print(error)
//            return
//        }
//    }
//}
//
//extension QRScannerController: AVCaptureMetadataOutputObjectsDelegate {
//
//    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//
//        flag = false
//        if metadataObjects.count == 0 {
//            qrCodeFrameView?.frame = CGRect.zero
//            return
//        }
//
//        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
//
//
//        if metadataObj.type == AVMetadataObject.ObjectType.qr {
//            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
//            qrCodeFrameView?.frame = barCodeObject!.bounds
//
//            if metadataObj.stringValue != nil {
//                returnedQRString = metadataObj.stringValue
//
//                APIService.shared.qrCodeCheck(userId: 1, companyId: 1, qrCode: returnedQRString!) { [self] (result, error) in
//
//                    if flag == false {
//                        if let result = result {
//                            if result["ReturnCode"] as! Int == 0 {
//
//                                flag = true
//
//                                DispatchQueue.main.async {
//
//                                    if let qrCodeFrameView = qrCodeFrameView {
//                                        qrCodeFrameView.layer.borderColor = mainColor.cgColor
//                                        qrCodeFrameView.layer.borderWidth = 5
//                                        view.addSubview(qrCodeFrameView)
//                                        view.bringSubviewToFront(qrCodeFrameView)
//                                    }
//
//                                    let alert = UIAlertController(title: "Success", message: "", preferredStyle: .alert)
//                                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
//                                        captureSession.startRunning()
//                                        qrCodeFrameView?.removeFromSuperview()
//                                    })
//
//                                    alert.addAction(defaultAction)
//                                    self.present(alert, animated: true)
//                                    Vibration.success.vibrate()
//
//                                }
//
//                                captureSession.stopRunning()
//                            }
//
//                            else {
//
//                                flag = false
//
//                                DispatchQueue.main.async {
//
//                                    if let qrCodeFrameView = qrCodeFrameView {
//                                        qrCodeFrameView.layer.borderColor = mainColor.cgColor
//                                        qrCodeFrameView.layer.borderWidth = 5
//                                        view.addSubview(qrCodeFrameView)
//                                        view.bringSubviewToFront(qrCodeFrameView)
//                                    }
//
//                                    let alert = UIAlertController(title: "Error!", message: (result["ExceptionMessage"] as! String), preferredStyle: .alert)
//                                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
//                                        captureSession.startRunning()
//                                        qrCodeFrameView?.removeFromSuperview()
//                                    })
//
//                                    alert.addAction(defaultAction)
//                                    self.present(alert, animated: true)
//                                    Vibration.error.vibrate()
//                                }
//                                captureSession.stopRunning()
//                            }
//                        }
//
//                        if let error = error {
//                             print("error: \(error.localizedDescription)")
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
