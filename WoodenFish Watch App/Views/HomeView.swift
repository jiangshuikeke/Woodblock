//
//  HomeView.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/28.
//

import SwiftUI
import AVFoundation
import AVKit
import CoreMotion
import Combine
import Foundation

class TimeHelper{
    var canceller:AnyCancellable?
    
    func start(receiveValue:@escaping (() -> Void)){
        let publisher = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
        
        //每一秒都去执行这个receiveValue()方法
        self.canceller = publisher.sink(receiveValue: { data in
            receiveValue()
        })
    }
    
    func stop(){
        canceller?.cancel()
        canceller = nil
    }
}

struct HomeView: View {
    @EnvironmentObject var userModel:UserModel
    
    @State var isTap:Bool = false
    @State var count = 0
    @State var isShowWord:Bool = false
    var timer:TimeHelper = TimeHelper()
    @State var publisher:Publishers.Autoconnect<Timer.TimerPublisher>?
    @State var canceller:AnyCancellable?
    
    var motionManager:CMMotionManager = CMMotionManager()
    var body: some View {
        ZStack{
            woodenfish
            
            if userModel.config.isShowWord{
                Text(userModel.config.word)
                    .foregroundColor(.white)
                    .font(Font.system(size: 16))
                    .opacity(isShowWord ?1.0:0.0)
                    .offset(y:-66)
//                    .offset(y:isShowWord ? -30:0)
            }
            
            
            if userModel.config.isShowCounter{
                counter
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
                    .padding(.trailing,12)
                    .padding(.top,8)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(
            styles[userModel.config.styleIndex]
            .backgroundColor
        )
        .onAppear{
            initConfig()
        }
        .onDisappear{
            userModel.saveConfig()
            canceller?.cancel()
        }
        
    }
    
    var woodenfish:some View{
        styles[userModel.config.styleIndex].image
            .resizable()
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .aspectRatio(contentMode: .fit)
            .scaleEffect(isTap ?1.1:1.0)
            .onTapGesture {
                knock()
            }
    }
    
    var counter:some View{
        VStack(alignment: .trailing){
            Text("\(count)")
                .foregroundColor(.white)
            Text("\(userModel.config.sumCount)")
                .font(.callout)
                .foregroundColor(.white.opacity(0.8))
        }
    }
    
    ///初始化用户配置
    func initConfig(){
        if userModel.config.isShake{
            startUpdateAcc()
        }
        
        if userModel.config.isAutoKnock{
            publisher = nil
            //开启自动敲击
            publisher = Timer.publish(every: userModel.config.currentKnockInterval,tolerance: 1, on: .main, in: .common)
                .autoconnect()
    
            canceller = publisher?.sink(receiveValue: { data in
                let t = UInt32(userModel.config.deviation * 10) + 1
                let random = CGFloat(arc4random() % t) / 10
                DispatchQueue.main.asyncAfter(deadline: .now() + random){
                    autoKnock()
                }
            })
           
        }
        player = nil
       
    }
    
    func vibrator(){
        WKInterfaceDevice.current().play(.click)
    }
    
    func autoKnock(){
        if userModel.config.isStopAutoKnock{
            canceller?.cancel()
            canceller = nil
        }else{
            knock()
            userModel.config.stopTime -= 1
        }
    }
        
    func knock(){
        withAnimation(.spring(response: 0.6,dampingFraction: 0.8)){
            isTap.toggle()
        }
        isTap.toggle()
        withAnimation {
            isShowWord.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            isShowWord.toggle()
        }
        count += 1
        userModel.config.sumCount += 1
        
        playMusic()
        
        if userModel.config.isVibrator{
            vibrator()
        }
    }
    
    func startUpdateAcc(){
        if motionManager.isAccelerometerAvailable{
            let level = userModel.config.shakeLevel
            motionManager.startAccelerometerUpdates(to: .main) { data, error in
                guard error != nil else { return }
                if data!.acceleration.x > level.0 || data!.acceleration.y > level.1{
                    knock()
                }
            }
        }else{
            print("该设备不支持陀螺仪")
        }
    }
    
    @State var player:AVAudioPlayer?
    var nowPlayer:AVAudioPlayer?{
        guard let path = Bundle.main.path(forResource: styles[userModel.config.styleIndex].audio, ofType: "mp3") else{
            print("无法找到woodenfish.mp3文件")
            return nil
        }
        let url = URL(filePath: path)
        do{
            let player = try?AVAudioPlayer(contentsOf:url)
            player?.prepareToPlay()
            return player
        }
    }
    func playMusic(){
        if WKInterfaceDevice.current().supportsAudioStreaming{
            if player == nil{
                player = nowPlayer
            }
            player?.stop()
            player?.currentTime = 0
            player?.play()
        }else{
            print("该设备不支持播放音频")
        }
       
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
