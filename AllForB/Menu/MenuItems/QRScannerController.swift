//
//  QRScannerController.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/11.
//

import UIKit
import AVFoundation

class QRScannerController : UIViewController {
    
    var captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var qrCodeFrameView: UIView?
    var qrString: String!
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

extension QRScannerController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .front)
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
        }
        catch {
            print(error)
            return
        }
    }
    func displaySoundsAlert() {
        let alert = UIAlertController(title: "Play Sound", message: nil, preferredStyle: UIAlertController.Style.alert)
        for i in 1000...1010 {
            alert.addAction(UIAlertAction(title: "\(i)", style: .default, handler: {_ in
                AudioServicesPlayAlertSound(UInt32(i))
                self.displaySoundsAlert()
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    override open var shouldAutorotate: Bool { return false }
    override var prefersStatusBarHidden: Bool {return true}
}

extension QRScannerController {
    func found(stringCode: String) {
        APIService.shared.qrCodeCheck(userId: userId!, companyId: 1, qrCode: qrString) { [self] (result, err) in
            if let error = err {
                print(error)
                return
            }
            if let result = result {
                if result["ReturnCode"] as! Int == 0 {
                    DispatchQueue.main.async {
                        qrCodeFrameView?.frame = .zero
                    }
                    Vibration.success.vibrate()
                    AudioServicesPlayAlertSound(SystemSoundID(1407))

                    captureSession.stopRunning()
                    sleep(1)
                    DispatchQueue.main.async {
                        qrCodeFrameView?.frame = .zero
                    }
                    captureSession.startRunning()
                    print("Success")
                }
                else {
                    AudioServicesPlayAlertSound(SystemSoundID(1101))
                    Vibration.error.vibrate()
                    captureSession.stopRunning()
                    sleep(1)
                    DispatchQueue.main.async {
                        qrCodeFrameView?.frame = .zero
                    }
                    captureSession.startRunning()
                    print(result["ExceptionMessage"] as! String)
                }
            }
        }
    }
}

extension QRScannerController: AVCaptureMetadataOutputObjectsDelegate {
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
            found(stringCode: stringValue)
        }
    }
}
