//
//  ShakeManager.swift
//  WoodenFish
//
//  Created by 陈沈杰 on 2022/11/24.
//

import Foundation
import CoreMotion

class ShakeManager{

    init(){
        //加速度采样间隔
        motionManager.accelerometerUpdateInterval = 0.5
        
    }
    
    //MARK: - 变量
    open weak var delegate:ShakeDelegate?
    private lazy var motionManager:CMMotionManager = CMMotionManager()
}

extension ShakeManager{
    func startMotionUpdtae(){
        if motionManager.isAccelerometerAvailable{
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, error in
                guard let self = self else{ return }
                if let error = error{
                    self.motionManager.stopAccelerometerUpdates()
                    self.delegate?.failToUpdate()
                    return
                }else{
                    //三个轴上的加速度
                    self.delegate?.startUpdate(data: data!)
                }
            }
        }else{
            delegate?.failToUpdate()
        }
    }
    
    func stopMotionUpdate(){
        motionManager.stopAccelerometerUpdates()
    }
}


protocol ShakeDelegate:NSObjectProtocol{
    func startUpdate(data:CMAccelerometerData)
    
    func failToUpdate()
}
