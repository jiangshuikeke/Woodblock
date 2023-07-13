//
//  ViewController.swift
//  WoodenFish
//
//  Created by 陈沈杰 on 2022/11/21.
//

import UIKit
import SnapKit
import AudioToolbox
import CoreMotion
import AVFoundation
import WidgetKit
/**
 首页
 */
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        config.saveToPlist()
        changeModel()
        super.viewDidDisappear(animated)
        print("视图隐藏")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UserConfigurationChange, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        config.saveToPlist()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

    //MARK: - 变量
    private lazy var plistManager:PlistManager = PlistManager.shared
    
    private lazy var settingButton:UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "setting")
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(enterSettingPage), for: .touchUpInside)
        return button
    }()
    
    private lazy var currentKnockLabel:UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "\(currentCount)")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "Poppins-Black", size: 28)!,.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clearCount)))
        return label
    }()
    
    private lazy var sumKnockLabel:UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "\(SumCount)")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 16),.foregroundColor: UIColor(red: 0.82, green: 0.65, blue: 0.45, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clearCount)))
        return label
    }()
    
    private lazy var woodenFish:UIImageView = {
        let image = UIImageView(image: UIImage(named: "woodenfish"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var woodenFishDescription:UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "木鱼")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 16),.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        view.addSubview(label)
        return label
    }()
    
    //暂停按钮
    private lazy var pauseButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "home_pause"), for: .normal)
        button.addTarget(self, action: #selector(changeModel), for: .touchUpInside)
        return button
    }()
    
    //暂停蒙版
    private lazy var maskView:UIView = {
        let mask = UIView(frame: view.frame)
        mask.backgroundColor = .black.withAlphaComponent(0.6)
        
        mask.isUserInteractionEnabled = true
        mask.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startAutoKnock)))
        return mask
    }()
    
    
    
    ///木鱼切换
    private lazy var preButton:UIButton = {
        let bt = UIButton()
        bt.tag = 0
        bt.addTarget(self, action: #selector(changeStyle(sender:)), for: .touchUpInside)
        return bt
    }()
    
    private lazy var nextButton:UIButton = {
        let bt = UIButton()
        bt.tag = 1
        bt.addTarget(self, action: #selector(changeStyle(sender:)), for: .touchUpInside)
        return bt
    }()
    
    private var config:UserConfiguration = UserConfiguration(){
        didSet{
            configPage()
        }
    }
    
    private var style:WoodenFishStyle = woodenFishs[0]{
        didSet{
            view.backgroundColor = style.backgroundColor
            woodenFish.image = style.image
            woodenFishDescription.text = style.name
            woodenFishDescription.textColor = style.componentColor.withAlphaComponent(0.8)
            currentKnockLabel.textColor = style.componentColor.withAlphaComponent(0.8)
            sumKnockLabel.textColor = style.componentColor.withAlphaComponent(0.8)
            settingButton.setImage(UIImage(named: "setting")?.withTintColor(style.componentColor, renderingMode: .alwaysOriginal), for: .normal)
            //修改
            
//            pauseButton.setImage(UIImage(named: "home_pause")?.withTintColor(style.pauseColor, renderingMode: .alwaysOriginal), for: .normal)
            changeModelButtonImage()
            preButton.setImage(UIImage(systemName: "chevron.left")?.withTintColor(style.componentColor, renderingMode: .alwaysOriginal), for: .normal)
            nextButton.setImage(UIImage(systemName: "chevron.right")?.withTintColor(style.componentColor, renderingMode: .alwaysOriginal), for: .normal)
            
            //修改音效
            player = nil
        }
    }
    
    private lazy var knockWoodenFish:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(knock))
    
    private var currentCount:Int = 0
    //自动敲击相关
    private var autoTimer:Timer?
       
    private lazy var motionManager = ShakeManager()
    private var player:AVAudioPlayer?
    private var auPlayer:AVAudioPlayer {
        guard let path = Bundle.main.path(forResource: style.audio, ofType: "mp3") else{
            print("无法找到woodenfish.mp3文件")
            return AVAudioPlayer()
        }
        let url = URL(string: path)!
        do{
            let player = try?AVAudioPlayer(contentsOf:url)
            player?.prepareToPlay()
            return player!
        }
    }
    
    //展示的style
    private var stylesIsShow:[Bool]{
        plistManager.loadSettingStyles()
    }
    
    //取出当前显示的cell
    private var isShowIndex:[Int] {
        var arr = [Int]()
        for (index,show) in stylesIsShow.enumerated() {
            if show{
                arr.append(index)
            }
        }
        return arr
    }
    
    private var nowStyleIndex:Int{
        return isShowIndex.firstIndex(of: config.styleIndex) ?? 0
    }
    
    private var tempCount:Int = 0
}

extension HomeViewController{
    func initView(){
        motionManager.delegate = self
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .black
        view.addSubview(settingButton)
        view.addSubview(pauseButton)
        //
        view.addSubview(woodenFish)
        view.addSubview(currentKnockLabel)
        view.addSubview(sumKnockLabel)
        view.addSubview(woodenFishDescription)
        //
        view.addSubview(preButton)
        view.addSubview(nextButton)
        
        //暂停蒙版
        //        maskView.isHidden = true
        //        view.addSubview(maskView)
        
        woodenFish.isUserInteractionEnabled = true
        woodenFish.addGestureRecognizer(knockWoodenFish)
        initLayout()
        config = plistManager.loadUserConfiguration()
        sumKnockLabel.text = "\(SumCount)"
        addNotification()
    }
    
    func initLayout(){
        
        currentKnockLabel.snp.makeConstraints { make in
            make.left.equalTo(view).offset(28)
            make.top.equalTo(view).offset(50)
        }
        
        sumKnockLabel.snp.makeConstraints { make in
            make.top.equalTo(currentKnockLabel.snp.bottom).offset(-6)
            make.left.equalTo(currentKnockLabel)
        }
        
        settingButton.snp.makeConstraints { make in
            make.height.width.equalTo(44)
            make.right.equalTo(view).offset(-MarginPadding)
            make.top.equalTo(currentKnockLabel)
        }
        
        pauseButton.snp.makeConstraints { make in
            make.right.equalTo(settingButton.snp.left).offset(-16)
            make.centerY.equalTo(settingButton)
            make.height.width.equalTo(44)
        }
        
        woodenFish.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.width.equalTo(390)
        }
        
        woodenFishDescription.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-29)
            make.centerX.equalTo(view)
        }
        
        preButton.snp.makeConstraints { make in
            make.right.equalTo(woodenFishDescription.snp.left).offset(-8)
            make.centerY.equalTo(woodenFishDescription)
            make.height.width.equalTo(44)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.equalTo(woodenFishDescription.snp.right).offset(8)
            make.centerY.equalTo(woodenFishDescription)
            make.height.width.equalTo(44)
        }
        
    }
    
    func configPage(){
        if autoTimer != nil{
            autoTimer?.invalidate()
            autoTimer = nil
        }
        isHidenComponments()
        config.tempCount = config.stopKnockTime
        //风格改变
        style = woodenFishs[config.styleIndex]
        
        if isShowIndex.count == 1{
            preButton.isHidden = true
            nextButton.isHidden = true
        }
        
        //清零计数改变
        if SumCount == 0{
            currentCount = 0
            currentKnockLabel.text = "0"
            sumKnockLabel.text = "0"
        }
        
        //是否开启摇晃敲击
        if config.shakeIndex != 0{
            motionManager.startMotionUpdtae()
        }else{
            motionManager.stopMotionUpdate()
        }
        
        //配置自动敲击
        if config.isAutoKnock{
            
            startAutoKnock()
        }else{
            //            maskView.isHidden = true
        }
        changeModelButtonImage()
    }
    
    func changeModelButtonImage(){
        if config.isAutoKnock{
            pauseButton.setImage(UIImage(named: "home_pause")?.withTintColor(style.pauseColor, renderingMode: .alwaysOriginal), for: .normal)
        }else{
            pauseButton.setImage(UIImage(named: "auto")?.withTintColor(style.pauseColor, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
    func isHidenComponments(){
        if config.isShowCounter{
            currentKnockLabel.isHidden = false
            sumKnockLabel.isHidden = false
        }else{
            currentKnockLabel.isHidden = true
            sumKnockLabel.isHidden = true
        }
    }
    
    func addNotification(){
        NotificationCenter.default.addObserver(forName: UserConfigurationChange, object: nil, queue: .main) { [weak self] noti in
            guard let self = self else{ return }
            self.config = self.plistManager.loadUserConfiguration()
        }
        
        NotificationCenter.default.addObserver(forName: PauseAutoKonck, object: nil, queue: .main) {[weak self] noti in
            guard let self = self else{ return }
            self.pauseAutoKnock()
        }
    }
    
    func toast(){
        let toastLabel = UILabel(frame: CGRect(x: 81, y: 538, width: ScreenWidth - 162, height: 60))
        if config.isAutoKnock{
            toastLabel.text = "开启自动敲击模式"
        }else{
            toastLabel.text = "开启手动敲击模式"
        }
        toastLabel.textColor = .black
        toastLabel.font = UIFont.systemFont(ofSize: 20)
        toastLabel.textAlignment = .center
        toastLabel.layer.cornerRadius = CornerRadius
        toastLabel.layer.masksToBounds = true
        toastLabel.alpha = 0.0
        toastLabel.backgroundColor = .white.withAlphaComponent(0.8)
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.8, delay: 0) {
            toastLabel.alpha = 1.0
        }completion: { flag in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                toastLabel.alpha = 0.0
                toastLabel.removeFromSuperview()
            }
        }
    }
    
    
}

//MARK: - 点击事件
extension HomeViewController{
    @objc
    func enterSettingPage(){
        //如果有自动敲击则先暂停
//        if config.isAutoKnock{
//            changeModel()
//        }
        config.saveToPlist()
        present(UINavigationController(rootViewController: SettingViewController()) , animated: true)
    }
    
    @objc
    func knock(){
        //当前计数+1 总共计数+1
        currentCount += 1
        currentKnockLabel.text = "\(currentCount)"
//        config.count += 1
        var count = SumCount
        count += 1
        sumKnockLabel.text = "\(count)"
        UserDefaults.standard.setValue(count, forKey: "SumCount")
        //显示敲击文字
        if config.isShowWord{
            showKnockLabel()
        }
        
        //图片放大
        if woodenFish.layer.animation(forKey: "scale") != nil{
            woodenFish.layer.removeAnimation(forKey: "scale")
        }else{
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.duration = 0.1
            animation.fromValue = 1.0
            animation.toValue = 1.05
            animation.autoreverses = true
            animation.beginTime = CACurrentMediaTime()
            woodenFish.layer.add(animation, forKey: "scale")
        }

    
        //发出声音
        playMusic()
        
        //是否震动
        if config.vibratorIndex != 0{
            vibrator()
        }
    }
    
    @objc
    func autoKnock(){
        if config.isAutoStop{
            autoTimer?.invalidate()
            changeModel()
//            stopAutoKnock()
        }else{
            let t = UInt32(config.deviationInterval * 10) + 1
            let random = CGFloat(arc4random() % t) / 10
            autoTimer?.fireDate = Date().advanced(by: random + config.autoKnockInterval)
            knock()
            config.tempCount -= 1
        }
    }
    
    func showKnockLabel(){
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: config.showWord)
        label.frame = CGRect(x: 166, y: 211, width: 120, height: 180)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 32),.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        view.addSubview(label)
        UIView.animate(withDuration: 1.4, delay: 0) {
            label.frame.origin.y -= 88
            label.alpha = 0.0
        }completion: { flag in
            //移除label
            label.removeFromSuperview()
        }
    }
    
    func playMusic(){
        if player == nil{
            player = auPlayer
        }
        if config.isRandomVolume{
            player?.volume = RandomVolume
        }
        //重置音频
        player?.stop()
        player?.currentTime = 0
        player?.play()
    }
    
    func vibrator(){
        let gen = UIImpactFeedbackGenerator(style: config.vibratorLevel)
        gen.impactOccurred()
    }
    
    private var autoT:Timer{
        return Timer.scheduledTimer(timeInterval: config.autoKnockInterval, target: self, selector: #selector(autoKnock), userInfo: nil, repeats: true)
    }
    
    @objc
    func startAutoKnock(){
//        maskView.isHidden = true
        //木鱼名称改变
        if config.autoKnockIndex != 0{
            woodenFishDescription.text = "\(style.name)-\(config.autoKnockName)"
        }

        if autoTimer != nil{
            if !autoTimer!.isValid{
                autoTimer = autoT
            }
            RunLoop.current.add(autoTimer!, forMode: .common)
        }else{
            autoTimer = autoT
        }
    }
    
    @objc
    func changeModel(){
        config.isAutoKnock = !config.isAutoKnock
        if config.isAutoKnock{
            startAutoKnock()
        }else{
            woodenFishDescription.text = "\(style.name)"
            autoTimer?.invalidate()
        }
        changeModelButtonImage()
        toast()
    }
    
    ///暂停自动
    func pauseAutoKnock(){
        autoTimer?.invalidate()
        config.isAutoKnock = false
        changeModelButtonImage()
        toast()
    }
    
    @objc
    func stopAutoKnock(){
        //隐藏暂停按钮
        pauseButton.isHidden = true
        //自动敲击取消
        config.isAutoKnock = false
    }
    
    ///清除总敲击数
    @objc
    func clearCount(){
        let alert = UIAlertController(title: "提示", message:"是否清零计数" , preferredStyle: .alert)
        let ok = UIAlertAction(title: "确定", style: .default) {[weak self] action in
            guard let self = self else { return }
            self.currentCount = 0
            self.currentKnockLabel.text = "0"
            UserDefaults.standard.setValue(0, forKey: "SumCount")
            self.sumKnockLabel.text = "0"
        }
        alert.addAction(ok)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc
    func changeStyle(sender:UIButton){
        let tag = sender.tag
        var index = nowStyleIndex
        //向前
        if tag == 0{
            index -= 1
            if index < 0{ return }
        }else{
            index += 1
            if index == isShowIndex.count{ return }
        }
        config.styleIndex = isShowIndex[index]
        style = woodenFishs[isShowIndex[index]]
        //通知小组件
        GroupManager.shared.styleIndex = isShowIndex[index]
        WidgetCenter.shared.reloadAllTimelines()
    }
    
}

extension HomeViewController:ShakeDelegate{
    func failToUpdate() {
        //更新设置
        config.shakeIndex = 0
        let alert = UIAlertController(title: "错误", message: "无法通过摇晃来敲击木鱼", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好的", style: .default))
        present(alert, animated: true)
    }
    
    func startUpdate(data: CMAccelerometerData) {
        let level = config.shakeLevel
        let accx = abs(data.acceleration.x)
        let accy = abs(data.acceleration.y)
        if accx > level.0 || accy > level.1{
            knock()
        }
    }
}
