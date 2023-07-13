//
//  AdvancedSettingViewController.swift
//  WoodenFish
//
//  Created by 陈沈杰 on 2022/11/21.
//

import UIKit

/**
 高级设置
 */
class AdvancedSettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollview.contentSize = CGSize(width: ScreenWidth, height: versionLabel.frame.maxY + 16)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        saveConfiguration()
        
    }
    
    //MARK: - 变量
    private lazy var leftAc:UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "chevron.left")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        bt.addTarget(self, action: #selector(pop), for: .touchUpInside)
        return bt
    }()
    
    private lazy var closeButton:UIButton = {
        var config = UIButton.Configuration.plain()
        let attrString = AttributedString("关闭",attributes: AttributeContainer([.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(red: 0.42, green: 0.53, blue: 1, alpha: 1)]))
        config.attributedTitle = attrString
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "高级设置")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 16),.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()
    
    private lazy var scrollview:UIScrollView = UIScrollView(frame: view.frame)

    //MARK: - 第一行设置
    
    //随机音量
    private lazy var randVolumeView:UIView = {
        let bt = UIButton(image: "random_volume", title: "随机音量")
        let sw = UISwitch()
        sw.isOn = config.isRandomVolume
        sw.addTarget(self, action: #selector(isRandomVolume(sender:)), for: .valueChanged)
        
        let rand = UIView(cornerRadius: 8.0)
        rand.addSubview(bt)
        rand.addSubview(sw)
        
        bt.snp.makeConstraints { make in
            make.left.equalTo(rand.snp.left).offset(52)
            make.top.equalTo(rand).offset(16)
            make.width.height.equalTo(26)
        }
        
        sw.snp.makeConstraints { make in
            make.right.equalTo(rand).offset(-16)
            make.centerY.equalTo(bt)
        }
        
        return rand
    }()
    
    //MARK: - 第二行设置
    private lazy var showCounterView:UIView = {
        let bt = UIButton(image: "counter", title: "显示计数器")
        let sw = UISwitch()
        sw.addTarget(self, action: #selector(isShowCounter(sender:)), for: .valueChanged)
        sw.isOn = config.isShowCounter
        let clear = UIButton()
        clear.setAttributedTitle(NSAttributedString(string: "清零计数",attributes: [.font:FontBody,.foregroundColor:UIColor(hexStr: "0x6B87FF")]), for: .normal)
        clear.addTarget(self, action: #selector(clearCount), for: .touchUpInside)
        
        let counter = UIView(cornerRadius: 8.0)
        counter.addSubview(bt)
        counter.addSubview(sw)
        counter.addSubview(clear)
        
        bt.snp.makeConstraints { make in
            make.left.equalTo(counter).offset(56)
            make.top.equalTo(counter).offset(16)
            make.width.height.equalTo(26)
        }
        
        sw.snp.makeConstraints { make in
            make.right.equalTo(counter).offset(-16)
            make.centerY.equalTo(bt)
        }
        
        clear.snp.makeConstraints { make in
            make.left.equalTo(counter).offset(16)
            make.top.equalTo(bt.snp.bottom).offset(12)
        }
        
        return counter
    }()
    
    //MARK: - 第三行设置
    private lazy var lightView:UIView = {
        let light = UIView(cornerRadius: 8.0)
        
        let bt = UIButton(image: "light", title: "保持屏幕常亮")
        let sw = UISwitch()
        sw.isOn = config.isScreenOn
        sw.addTarget(self, action: #selector(isScreenOn(sender:)), for: .valueChanged)
        
        light.addSubview(bt)
        light.addSubview(sw)
        
        bt.snp.makeConstraints { make in
            make.left.equalTo(light).offset(62)
            make.top.equalTo(light).offset(16)
            make.width.height.equalTo(26)
        }
        
        sw.snp.makeConstraints { make in
            make.right.equalTo(light).offset(-16)
            make.centerY.equalTo(bt)
        }
    
        return light
    }()
    
    //MARK: - 第四行设置
    private lazy var vibratorView:UIView = {
        let vibrate = UIView(cornerRadius: 8.0)
        let bt = UIButton(image: "vibrator", title:"震动")
        let segment = UISegmentedControl(titles: ["关闭","轻羽","踏雪","华展"])
        segment.selectedSegmentIndex = config.vibratorIndex
        segment.addTarget(self, action: #selector(vibratorSegment(sender:)), for: .valueChanged)
        vibrate.addSubview(bt)
        vibrate.addSubview(segment)
        
        bt.snp.makeConstraints { make in
            make.left.equalTo(vibrate).offset(36)
            make.top.equalTo(vibrate).offset(16)
            make.width.height.equalTo(26)
        }
        
        segment.snp.makeConstraints { make in
            make.right.equalTo(vibrate).offset(-12)
            make.centerY.equalTo(bt)
            make.width.equalTo(240)
            make.height.equalTo(30)
        }
        return vibrate
    }()
    
    //MARK: - 第五行设置
    private lazy var shakeView:UIView = {
        let shake = UIView(cornerRadius: 8.0)
        let bt = UIButton(image: "shake", title:"摇晃")
        let segment = UISegmentedControl(titles: ["关闭","随意","轻甩","用力"])
        segment.selectedSegmentIndex = config.shakeIndex
        segment.addTarget(self, action: #selector(shakeSegment(sender: )), for: .valueChanged)
        shake.addSubview(bt)
        shake.addSubview(segment)
        
        bt.snp.makeConstraints { make in
            make.left.equalTo(shake).offset(36)
            make.top.equalTo(shake).offset(16)
            make.width.height.equalTo(26)
        }
        
        segment.snp.makeConstraints { make in
            make.right.equalTo(shake).offset(-12)
            make.centerY.equalTo(bt)
            make.width.equalTo(240)
            make.height.equalTo(30)
        }
        return shake
    }()
    
    //MARK: - 第六行设置
    private lazy var emailView:UIView = {
        let email = UIView(cornerRadius: 8)
        let bt = UIButton(image: "email", title: "邮箱")
        let label = UILabel()
        label.font = FontBody
        label.text = Email
        label.textColor = .white
        
        email.addSubview(bt)
        email.addSubview(label)
        
        bt.snp.makeConstraints { make in
            make.left.equalTo(email).offset(36)
            make.top.equalTo(email).offset(16)
            make.width.height.equalTo(26)
        }
        
        label.snp.makeConstraints { make in
            make.right.equalTo(email).offset(-16)
            make.centerY.equalTo(email)
        }
        
        return email
    }()
    
    //MARK: - 第七行设置
    private lazy var favorView:UIView = {
        let favor = UIView(cornerRadius: 8)
        let bt = UIButton(image: "favor", title: "给「木鱼」五星好评")
        favor.isUserInteractionEnabled = true
        favor.addSubview(bt)
        bt.snp.makeConstraints { make in
            make.left.equalTo(favor).offset(88)
            make.top.equalTo(favor).offset(16)
            make.width.height.equalTo(26)
        }
        favor.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favorWoodenFish)))
        
        return favor
    }()
    
    private lazy var versionLabel:UILabel = {
        let label = UILabel()
        label.text = Version
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(white: 1, alpha: 0.7)
        return label
    }()
    
    private lazy var plistManager = PlistManager.shared
    
    private lazy var config = plistManager.loadUserConfiguration()
}

//MARK: - UI
extension AdvancedSettingViewController{
    func initView(){
        view.addSubview(scrollview)
        view.addSubview(leftAc)
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.backgroundColor = BackgroundColor
        
        
        //设置
        scrollview.addSubview(randVolumeView)
        scrollview.addSubview(showCounterView)
        scrollview.addSubview(lightView)
        scrollview.addSubview(vibratorView)
        scrollview.addSubview(shakeView)
        scrollview.addSubview(emailView)
        scrollview.addSubview(favorView)
        scrollview.addSubview(versionLabel)
        initLayout()
    }
    
    func initLayout(){
        leftAc.snp.makeConstraints { make in
            make.left.equalTo(view).offset(24)
            make.top.equalTo(view).offset(16)
            make.width.equalTo(12)
            make.height.equalTo(23)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(leftAc)
        }
        
        closeButton.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-16)
            make.centerY.equalTo(leftAc)
        }
        
        scrollview.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(closeButton.snp.bottom)
        }
        
        randVolumeView.snp.makeConstraints { make in
            make.top.equalTo(scrollview).offset(27)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(58)
        }
        
        showCounterView.snp.makeConstraints { make in
            make.top.equalTo(randVolumeView.snp.bottom).offset(16)
            make.left.right.equalTo(randVolumeView)
            make.height.equalTo(90)
        }
        
        lightView.snp.makeConstraints { make in
            make.left.right.equalTo(showCounterView)
            make.height.equalTo(58)
            make.top.equalTo(showCounterView.snp.bottom).offset(16)
        }
        
        vibratorView.snp.makeConstraints { make in
            make.left.right.equalTo(lightView)
            make.top.equalTo(lightView.snp.bottom).offset(32)
            make.height.equalTo(62)
        }
        
        shakeView.snp.makeConstraints { make in
            make.left.right.equalTo(vibratorView)
            make.top.equalTo(vibratorView.snp.bottom).offset(16)
            make.height.equalTo(62)
        }
        
        emailView.snp.makeConstraints { make in
            make.left.right.equalTo(vibratorView)
            make.top.equalTo(shakeView.snp.bottom).offset(32)
            make.height.equalTo(58)
        }
        
        favorView.snp.makeConstraints { make in
            make.left.right.equalTo(vibratorView)
            make.top.equalTo(emailView.snp.bottom).offset(16)
            make.height.equalTo(58)
        }
        
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(favorView.snp.bottom).offset(95)
            make.centerX.equalTo(scrollview)
        }
    }
}

//MARK: - 按键
extension AdvancedSettingViewController{
    func saveConfiguration(){
        config.saveToPlist()
        NotificationCenter.default.post(name: UserConfigurationChange, object: nil)
    }
    
    @objc
    func closePage(){
        dismiss(animated: true)
    }
    
    @objc
    func pop(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func isRandomVolume(sender:UISwitch){
        config.isRandomVolume = sender.isOn
        saveConfiguration()
    }
    
    @objc
    func isShowCounter(sender:UISwitch){
        config.isShowCounter = sender.isOn
        saveConfiguration()
    }
    
    @objc
    func clearCount(){
        let alert = UIAlertController(title: "提示", message:"是否清零计数" , preferredStyle: .alert)
        let ok = UIAlertAction(title: "确定", style: .default) {[weak self] action in
            guard let self = self else { return }
            UserDefaults.standard.setValue(0, forKey: "SumCount")
            self.saveConfiguration()
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc
    func isScreenOn(sender:UISwitch){
        UIApplication.shared.isIdleTimerDisabled = sender.isOn
        config.isScreenOn = sender.isOn
        saveConfiguration()
    }
    
    @objc
    func vibratorSegment(sender:UISegmentedControl){
        config.vibratorIndex = sender.selectedSegmentIndex
        saveConfiguration()
    }
    
    @objc
    func shakeSegment(sender:UISegmentedControl){
        config.shakeIndex = sender.selectedSegmentIndex
        saveConfiguration()
    }
    
    @objc
    func favorWoodenFish(){
        
    }
}
