//
//  QRScannerController.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/11.
//

import UIKit
import AVFoundation

class QRScannerController: UIViewController {
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    var mainPageController: MainPageController?
    
    var flag: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .front)
//
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resize
            videoPreviewLayer?.frame = view.layer.bounds
            
            
            view.layer.addSublayer(videoPreviewLayer!)
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
}

extension QRScannerController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        flag = false
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }

        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds

            if metadataObj.stringValue != nil {
                returnedQRString = metadataObj.stringValue
                
                APIService.shared.qrCodeCheck(userId: 1, companyId: 1, qrCode: returnedQRString!) { [self] (result, error) in
                    
                    if flag == false {
                        if let result = result {
                            if result["ReturnCode"] as! Int == 0 {
                                
                                flag = true
                                print(result["ReturnCode"] as! Int)
                                
                                DispatchQueue.main.async {

                                    if let qrCodeFrameView = qrCodeFrameView {
                                        qrCodeFrameView.layer.borderColor = mainColor.cgColor
                                        qrCodeFrameView.layer.borderWidth = 5
                                        view.addSubview(qrCodeFrameView)
                                        view.bringSubviewToFront(qrCodeFrameView)
                                    }

                                    let alert = UIAlertController(title: "Success", message: "", preferredStyle: .alert)
                                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                                        captureSession.startRunning()
                                        qrCodeFrameView?.removeFromSuperview()
                                    })
                                    
                                    alert.addAction(defaultAction)
                                    self.present(alert, animated: true)
                                    Vibration.success.vibrate()
                                    
                                    
                                    
                                }

                                captureSession.stopRunning()
                            }
                            
                            else {
                                
                                flag = false

                                DispatchQueue.main.async {

                                    if let qrCodeFrameView = qrCodeFrameView {
                                        qrCodeFrameView.layer.borderColor = mainColor.cgColor
                                        qrCodeFrameView.layer.borderWidth = 5
                                        view.addSubview(qrCodeFrameView)
                                        view.bringSubviewToFront(qrCodeFrameView)
                                    }

                                    let alert = UIAlertController(title: "Error!", message: (result["ExceptionMessage"] as! String), preferredStyle: .alert)
                                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                                        captureSession.startRunning()
                                        qrCodeFrameView?.removeFromSuperview()
                                    })
                                    
                                    alert.addAction(defaultAction)
                                    self.present(alert, animated: true)
                                    Vibration.error.vibrate()
                                }
                                captureSession.stopRunning()
                            }
                        }
                        
                        if let error = error {
                             print("error: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}
