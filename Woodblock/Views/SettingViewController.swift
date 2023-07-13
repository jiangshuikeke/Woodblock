//
//  SettingViewController.swift
//  WoodenFish
//
//  Created by 陈沈杰 on 2022/11/21.
//

import UIKit
import WidgetKit

/**
 设置界面
 */
class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pauseSegmentChange(sender: pauseSegment)
        updateCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        saveConfiguration()
    }

    //MARK: - 变量
    private lazy var scrollview:UIScrollView = UIScrollView(frame: view.frame)
    
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
        let attrString = NSMutableAttributedString(string: "设置")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 16),.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()
    
    //MARK: - 第一行设置
    private lazy var showKnockLabel:UIView = {
        let layerView = UIView(cornerRadius: 8)
        // fillCode
        let bt = UIButton(image: "word", title: "咏诵显示文本")
        let sw = UISwitch()
        sw.isOn = config.isShowWord
        sw.addTarget(self, action: #selector(isShowLabel(sender:)), for: .valueChanged)
    
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "clear")
        let clearButton = UIButton(configuration: config)
        clearButton.addTarget(self, action: #selector(clearContent), for: .touchUpInside)
        
        layerView.addSubview(bt)
        layerView.addSubview(sw)
        layerView.addSubview(textview)
        layerView.addSubview(clearButton)
        
        bt.snp.makeConstraints { make in
            make.left.equalTo(layerView.snp.left).offset(64)
            make.top.equalTo(layerView).offset(16)
            make.width.height.equalTo(26)
        }
        
        sw.snp.makeConstraints { make in
            make.right.equalTo(layerView).offset(-16)
            make.centerY.equalTo(bt)
        }
        
        textview.snp.makeConstraints { make in
            make.top.equalTo(bt.snp.bottom).offset(10)
            make.left.equalTo(layerView).offset(16)
            make.right.equalTo(layerView).offset(-16)
            make.height.equalTo(60)
        }
       
        clearButton.snp.makeConstraints { make in
            make.right.equalTo(textview).offset(-8)
            make.bottom.equalTo(textview).offset(-8)
            make.width.height.equalTo(24)
        }
        
        
        return layerView
    }()
    
    private lazy var textview:UITextView = {
        let textview = UITextView()
        textview.text = config.showWord.isEmpty ?"功德+1":config.showWord
        textview.textColor = config.showWord.isEmpty ?UIColor(white: 1, alpha: 0.5):.white
        textview.textAlignment = .left
        textview.backgroundColor = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 1)
        textview.layer.cornerRadius = CornerRadius
        textview.layer.masksToBounds = true
        textview.delegate = self

        return textview
    }()
    
    //MARK: - 第二行设置
    private lazy var autoKnockView:UIView = {
        let autoView = UIView(cornerRadius: 8.0)
    
        let bt = UIButton(image: "auto_knock", title: "自动敲击")
        let sw = UISwitch()
        sw.isOn = config.isAutoKnock
        sw.addTarget(self, action: #selector(isAutoKnock(sender:)), for: .valueChanged)
        let reminderLabel = UILabel()
        reminderLabel.text = "自动当前时间间隔"
        reminderLabel.textColor = .white
        reminderLabel.font = FontBody
        autoSegment.selectedSegmentIndex = config.autoKnockIndex
        if config.autoKnockIndex != 0{
            autoIntervalSlider.isHidden = true
        }else{
            autoIntervalSlider.value = Float(config.autoKnockInterval)
        }
        autoIntervalLabel.text = String(format: "%1.1fs", config.autoKnockInterval)
        
        autoView.addSubview(bt)
        autoView.addSubview(sw)
        autoView.addSubview(autoSegment)
        autoView.addSubview(reminderLabel)
        autoView.addSubview(autoIntervalLabel)
        autoView.addSubview(autoIntervalSlider)
        
        bt.snp.makeConstraints { make in
            make.left.equalTo(autoView.snp.left).offset(52)
            make.top.equalTo(autoView).offset(16)
            make.width.height.equalTo(26)
        }
        
        sw.snp.makeConstraints { make in
            make.right.equalTo(autoView).offset(-16)
            make.centerY.equalTo(bt)
        }
        
        autoSegment.snp.makeConstraints { make in
            make.top.equalTo(bt.snp.bottom).offset(12)
            make.left.equalTo(autoView).offset(16)
            make.right.equalTo(autoView).offset(-16)
            make.height.equalTo(30)
        }
        
        reminderLabel.snp.makeConstraints { make in
            make.left.equalTo(autoSegment).offset(2)
            make.top.equalTo(autoSegment.snp.bottom).offset(12)
        }
        
        autoIntervalLabel.snp.makeConstraints { make in
            make.top.equalTo(reminderLabel)
            make.right.equalTo(autoView).offset(-16)
        }
        
        autoIntervalSlider.snp.makeConstraints { make in
            make.left.equalTo(reminderLabel.snp.right).offset(8)
            make.centerY.equalTo(reminderLabel)
            make.right.equalTo(autoIntervalLabel.snp.left).offset(-8)
        }
        return autoView
    }()
    
    private lazy var autoSegment:UISegmentedControl = {
        let segment = UISegmentedControl(titles: ["自由","深邃","生命","乐章","进发"])
        segment.addTarget(self, action: #selector(autoSegementSelected(sender:)), for: .valueChanged)
        
        segment.selectedSegmentIndex = config.autoKnockIndex
        return segment
    }()
    
    private lazy var autoIntervalLabel:UILabel = {
        let label = UILabel()
        label.font = FontBody
        label.textColor = UIColor(white: 1, alpha: 0.7)
        label.text = "\(config.autoKnockInterval)s"
        return label
    }()
    
    private lazy var autoIntervalSlider:UISlider = {
        let slider = UISlider()
        slider.maximumValue = 5.0
        slider.minimumValue = 0.1
        slider.tintColor = UIColor(hexStr: "0x4A80B5")
        slider.thumbTintColor = .white
        slider.addTarget(self, action: #selector(autoKonckInterval(sender:)), for: .valueChanged)
        return slider
    }()
    
    //MARK: - 第三行设置
    private lazy var pauseView:UIView = {
        let pauseView = UIView(cornerRadius: 8)
        
        let bt = UIButton(image: "pause", title: "停止敲击")
        pauseView.addSubview(bt)
        pauseView.addSubview(pauseSegment)
        
        bt.snp.makeConstraints { make in
            make.left.equalTo(pauseView).offset(52)
            make.top.equalTo(pauseView).offset(16)
            make.width.height.equalTo(26)
        }
        pauseSegment.snp.makeConstraints { make in
            make.right.equalTo(pauseView).offset(-16)
            make.top.equalTo(bt)
            make.height.equalTo(30)
        }
        return pauseView
    }()
    
    private lazy var pauseSegment:UISegmentedControl = {
        let segment = UISegmentedControl(titles: ["永不","时间","次数"])
        segment.addTarget(self, action: #selector(pauseSegmentChange(sender:)), for: .valueChanged)
        segment.selectedSegmentIndex = config.stopKnockIndex
        return segment
    }()
    
    private lazy var datePicker:UIDatePicker = {
        let picker = UIDatePicker()
        picker.calendar = NSCalendar.current
        picker.date = config.stopKnockDate
        picker.locale = Locale(identifier: "zh_CN")
        picker.setValue(UIColor.white, forKey: "textColor")
        picker.setValue(false, forKey: "highlightsToday")
        //东八区
        picker.timeZone = TimeZone(secondsFromGMT: 3600 * 8)
        return picker
    }()
    
    private lazy var timeSegment:UISegmentedControl = UISegmentedControl(titles: ["自定义","5分钟","10分钟","20分钟","30分钟"],font: UIFont.systemFont(ofSize: 12))
    
    private var timeIndex:Int = 0
    
    private lazy var timePauseLabel:UILabel = {
        let label = UILabel()
        label.text = "停止时间"
        label.font = FontBody
        label.textColor = .white
        return label
    }()
    
    private lazy var stopTimeLabel:UITextField = {
        let label = UITextField()
        label.keyboardType = .numberPad
        label.placeholder = "停止次数"
        label.setValue(UIColor(white: 1, alpha: 0.3), forKeyPath: "placeholderLabel.textColor")
        label.textColor = .white
        label.font = FontBody
        label.textColor = UIColor(white: 1, alpha: 0.3)
        if config.stopKnockTime != 0{
            label.text = "\(config.stopKnockTime)"
        }
        
        return label
    }()
    
    private lazy var countView:UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 6
        view.backgroundColor = UIColor(hexStr: "0x3D3C42")
        let add = UIButton()
        add.setImage(UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        add.addTarget(self, action: #selector(addCount), for: .touchUpInside)
        let div = UIView()
        div.backgroundColor = UIColor(hexStr: "0x979797")
        
        let reduce = UIButton()
        reduce.setImage(UIImage(systemName: "minus")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        reduce.addTarget(self, action: #selector(minusCount), for: .touchUpInside)
        
        view.addSubview(reduce)
        view.addSubview(div)
        view.addSubview(add)
        
        reduce.snp.makeConstraints{ make in
            make.left.equalTo(view).offset(9)
            make.centerY.equalTo(view)
        }
        div.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(1)
            make.height.equalTo(17)
        }
        add.snp.makeConstraints { make in
            make.left.equalTo(div.snp.right).offset(6)
            make.centerY.equalTo(view)
        }
    
        return view
    }()
    
    //MARK: - 第四行设置
    private lazy var deviationView:UIView = {
        let view = UIView(cornerRadius: 8)
        
        let bt = UIButton(image: "range", title: "间隔偏差度")
        let silder = UISlider()
        silder.tintColor = UIColor(hexStr: "0x4A80B5")
        silder.thumbTintColor = .white
        silder.addTarget(self, action: #selector(deviationSilder(sender:)), for: .valueChanged)
        silder.maximumValue = 5.0
        silder.value = Float(config.deviationInterval)
        
        
        view.addSubview(bt)
        view.addSubview(silder)
        view.addSubview(deviationLabel)
    
        
        bt.snp.makeConstraints { make in
            make.left.equalTo(view).offset(58)
            make.top.equalTo(view).offset(16)
            make.height.width.equalTo(26)
        }
        
        silder.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-48)
            make.centerY.equalTo(bt)
            make.height.equalTo(16)
            make.width.equalTo(120)
        }
        
        deviationLabel.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-16)
            make.centerY.equalTo(bt)
        }
        
        return view
    }()
    
    private lazy var deviationLabel:UILabel = {
        let deviation = UILabel()
        
        deviation.text = String(format: "%1.1f", config.deviationInterval)
        deviation.font = FontBody
        deviation.textColor = .white
        return deviation
    }()
    
    //MARK: - 第五行设置
    private lazy var instrumentView:UIView = {
        let instrument = UIView(cornerRadius: 8)
        
        let bt = UIButton(image: "instruments", title: "乐器选择")
        
        let countLabel = UILabel()
        countLabel.text = "\(woodenFishs.count)"
        countLabel.textColor = UIColor(white: 1, alpha: 0.7)
        countLabel.font = FontBody
        countLabel.isUserInteractionEnabled = true
        
        let imageView = UIImageView(image:UIImage(systemName: "chevron.right")?.withTintColor(.white, renderingMode: .alwaysOriginal))
        imageView.frame.size = CGSize(width: 6, height: 10)
        imageView.isUserInteractionEnabled = true
        
        bt.addTarget(self, action: #selector(enterInstrumentsPage), for: .touchUpInside)
        countLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(enterInstrumentsPage)))
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(enterInstrumentsPage)))
        
        
        instrument.addSubview(bt)
        instrument.addSubview(imageView)
        instrument.addSubview(countLabel)
        instrument.addSubview(instrumentCollectionView)
        
        bt.snp.makeConstraints { make in
            make.left.equalTo(instrument).offset(52)
            make.top.equalTo(instrument).offset(16)
            make.height.width.equalTo(26)
        }
        
        imageView.snp.makeConstraints { make in
            make.right.equalTo(instrument).offset(-16)
            make.centerY.equalTo(bt)
        }
        
        countLabel.snp.makeConstraints { make in
            make.right.equalTo(imageView.snp.left).offset(-6)
            make.centerY.equalTo(imageView)
        }
        
        instrumentCollectionView.snp.makeConstraints { make in
            make.top.equalTo(bt.snp.bottom).offset(16)
            make.left.right.bottom.equalTo(instrument)
        }
        
        return instrument
    }()
    
    private lazy var instrumentCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 66, height: 66)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(InstrumentsCollectionCell.self, forCellWithReuseIdentifier: InstrumentCellID)
        collectionview.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
        collectionview.backgroundColor = UIColor(hexStr: "0x2C2C2E")
        
        return collectionview
    }()

    let InstrumentCellID = "InstrumentCellID"
    
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
    
    //MARK: - 高级设置
    private lazy var advancedSettingView:UIView = {
        let bt = UIButton(image: "setting_gray", title: "高级设置")
        let imageView = UIImageView(image:UIImage(systemName: "chevron.right")?.withTintColor(.white, renderingMode: .alwaysOriginal))
        imageView.frame.size = CGSize(width: 6, height: 10)
        let advanced = UIView(cornerRadius: 8)
        
        
        advanced.addSubview(bt)
        advanced.addSubview(imageView)
        
        bt.snp.makeConstraints { make in
            make.left.equalTo(advanced).offset(52)
            make.top.equalTo(advanced).offset(16)
            make.height.width.equalTo(26)
        }
        
        imageView.snp.makeConstraints { make in
            make.right.equalTo(advanced).offset(-16)
            make.centerY.equalTo(bt)
        }
        
        advanced.isUserInteractionEnabled = true
        advanced.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(enterAdvancedSettingPage)))
        
        return advanced
    }()
    
    private lazy var plistManager:PlistManager = PlistManager.shared
    
    private lazy var config = plistManager.loadUserConfiguration()
}

//MARK: - UI
extension SettingViewController{
    func initView(){
        timeSegment.addTarget(self, action: #selector(dateSegementChange(sender:)), for: .valueChanged)
        scrollview.showsVerticalScrollIndicator = false
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = BackgroundColor
        view.addSubview(scrollview)
        scrollview.backgroundColor = BackgroundColor
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        //设置功能
        scrollview.addSubview(showKnockLabel)
        scrollview.addSubview(autoKnockView)
        scrollview.addSubview(pauseView)
        scrollview.addSubview(deviationView)
        scrollview.addSubview(instrumentView)
        scrollview.addSubview(advancedSettingView)
        
        initLayout()
        configPage()
    }
    
    func initLayout(){
        closeButton.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-MarginPadding)
            make.top.equalTo(view).offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(closeButton)
        }
        
        scrollview.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(closeButton.snp.bottom)
        }
        
        showKnockLabel.snp.makeConstraints { make in
            make.left.equalTo(view).offset(MarginPadding)
            make.right.equalTo(view).offset(-MarginPadding)
            make.height.equalTo(128)
            make.top.equalTo(scrollview).offset(MarginPadding)
        }
        
        autoKnockView.snp.makeConstraints { make in
            make.left.right.equalTo(showKnockLabel)
            make.height.equalTo(135)
            make.top.equalTo(showKnockLabel.snp.bottom).offset(32)
        }
        
        pauseView.snp.makeConstraints { make in
            make.left.right.equalTo(autoKnockView)
            make.height.equalTo(58)
            make.top.equalTo(autoKnockView.snp.bottom).offset(16)
        }
        
        deviationView.snp.makeConstraints { make in
            make.left.right.equalTo(pauseView)
            make.height.equalTo(58)
            make.top.equalTo(pauseView.snp.bottom).offset(16)
        }
        
        instrumentView.snp.makeConstraints { make in
            make.left.right.equalTo(deviationView)
            make.height.equalTo(140)
            make.top.equalTo(deviationView.snp.bottom).offset(32)
        }
        
        advancedSettingView.snp.makeConstraints { make in
            make.top.equalTo(instrumentView.snp.bottom).offset(16)
            make.left.right.equalTo(deviationView)
            make.height.equalTo(58)
        }
    }
    
    func configPage(){
        
    }
    
    //停止敲击
    @objc
    func showPauseView(){
        pauseView.snp.updateConstraints { make in
            make.height.equalTo(58)
        }
        updateScrollViewContentSize()
    }
    
    @objc
    func showPauseTime(){
        stopTimeLabel.removeFromSuperview()
        countView.removeFromSuperview()
        //设置字体颜色
        pauseView.addSubview(timeSegment)
        pauseView.addSubview(timePauseLabel)
        pauseView.addSubview(datePicker)
        timeSegment.snp.makeConstraints { make in
            make.top.equalTo(pauseSegment.snp.bottom).offset(12)
            make.left.equalTo(pauseView).offset(16)
            make.right.equalTo(pauseView).offset(-16)
            make.height.equalTo(30)
        }
        
        timePauseLabel.snp.makeConstraints { make in
            make.top.equalTo(timeSegment.snp.bottom).offset(16)
            make.left.equalTo(timeSegment)
        }
        
        datePicker.snp.makeConstraints { make in
            make.left.equalTo(timePauseLabel.snp.right).offset(61)
            make.right.equalTo(pauseView).offset(-16)
            make.centerY.equalTo(timePauseLabel)
        }
        
        pauseView.snp.updateConstraints { make in
            make.height.equalTo(144)
        }
        
        updateScrollViewContentSize()
    }
    
    @objc
    func showPauseCount(){
        timeSegment.removeFromSuperview()
        timePauseLabel.removeFromSuperview()
        datePicker.removeFromSuperview()
        
        pauseView.addSubview(stopTimeLabel)
        pauseView.addSubview(countView)
        
        stopTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(pauseView).offset(16)
            make.top.equalTo(pauseSegment.snp.bottom).offset(17)
        }
        
        countView.snp.makeConstraints { make in
            make.centerY.equalTo(stopTimeLabel).offset(4)
            make.right.equalTo(pauseView).offset(-16)
            make.width.equalTo(64)
            make.height.equalTo(30)
        }
        
        pauseView.snp.updateConstraints { make in
            make.height.equalTo(102)
        }
        
        updateScrollViewContentSize()
    }
    
    @objc
    func enterInstrumentsPage(){
        navigationController?.pushViewController(InstrumentsViewController(), animated: true)
    }
    
    func updateScrollViewContentSize(){
        pauseView.layoutIfNeeded()
        scrollview.layoutIfNeeded()
        scrollview.contentSize = CGSize(width: ScreenWidth, height: advancedSettingView.frame.maxY + 16)
    }
    
    func updateCollectionView(){
        //更新高度
        var height:CGFloat = 0
        if isShowIndex.count <= 4{
            height = 98 + 42
        }else if isShowIndex.count < 8 && isShowIndex.count > 4{
            height = 180 + 42
        }else{
            height = 262 + 42
        }
        //刷新数据
        instrumentCollectionView.reloadData()
        
        //选中当前
        if isShowIndex.count == 0{
            height = 42 + 16
        }else{
            //如果没有显示就不去选
            if isShowIndex.contains(config.styleIndex){
                let index = isShowIndex.firstIndex{ $0 == config.styleIndex }!
                instrumentCollectionView.selectItem(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .top)
            }
        }
        instrumentView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        instrumentView.layoutIfNeeded()
        view.layoutIfNeeded()
        scrollview.contentSize = CGSize(width: ScreenWidth, height: advancedSettingView.frame.maxY + 16)
        
        
    }
}

//MARK： - textview delegate
extension SettingViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        textView.textColor = .white
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if config.showWord.isEmpty{
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        config.showWord = textView.text
        saveConfiguration()
    }
}

//MARK: - 设置有关
extension SettingViewController{
    @objc
    func closePage(){
        //保存设置
//        saveConfiguration()
        //
        dismiss(animated: true)
    }
    
    //第一行设置相关
    @objc
    func isShowLabel(sender:UISwitch){
        config.isShowWord = sender.isOn
        saveConfiguration()
    }
    
    @objc
    func clearContent(){
        textview.text = ""
    }
    
    //第二行设置相关
    @objc
    func isAutoKnock(sender:UISwitch){
        config.isAutoKnock = sender.isOn
        saveConfiguration()
    }
    
    @objc
    func autoSegementSelected(sender:UISegmentedControl){
        let index = sender.selectedSegmentIndex
        config.autoKnockIndex = index
        if index == 0{
            autoIntervalSlider.isHidden = false
            autoIntervalSlider.value = 1.0
            autoIntervalLabel.text = "1.0s"
            config.autoKnockInterval = 1.0
        }else{
            autoIntervalSlider.isHidden = true
            //保存
            config.autoKnockInterval = config.autoInterval
            //显示
            autoIntervalLabel.text = "\(config.autoInterval)s"
        }
        saveConfiguration()
    }
    
    //自动敲击的间隔
    @objc
    func autoKonckInterval(sender:UISlider){
        let value = sender.value
        autoIntervalLabel.text = String(format: "%1.1fs", value)
        config.autoKnockInterval = CGFloat(value)
        saveConfiguration()
    }
        
    //暂停
    @objc
    func pauseSegmentChange(sender:UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            config.stopKnockIndex = 0
            showPauseView()
            break
        case 1:
            config.stopKnockIndex = 1
            showPauseTime()
        case 2:
            config.stopKnockIndex = 2
            showPauseCount()
        default:
            break
        }
        saveConfiguration()
    }
    
    @objc
    func addCount(){
        var count = config.stopKnockTime
        count += 1
        config.stopKnockTime = count
        stopTimeLabel.text = "\(count)"
//        saveConfiguration()
    }
    
    @objc
    func minusCount(){
        var count = config.stopKnockTime
        count -= 1
        if count < 0{
            count = 0
        }
        config.stopKnockTime = count
        stopTimeLabel.text = "\(count)"
//        saveConfiguration()
    }
    
    //日期
    @objc
    func dateSegementChange(sender:UISegmentedControl){
        var date = datePicker.date
        if sender.selectedSegmentIndex != 0{
            date = config.stopDate(index: sender.selectedSegmentIndex)
        }
        timeIndex = sender.selectedSegmentIndex
        config.stopKnockDate = date
//        saveConfiguration()
    }
    

    //时间间隔差
    @objc
    func deviationSilder(sender:UISlider){
        let value = sender.value
        deviationLabel.text = String(format: "%1.1f", value)
        config.deviationInterval = CGFloat(value)
        saveConfiguration()
    }
    
    //高级设置
    @objc
    func enterAdvancedSettingPage(){
        navigationController?.pushViewController(AdvancedSettingViewController(), animated: true)
    }
    
    func saveConfiguration(){
        config.saveToPlist()
        NotificationCenter.default.post(name: UserConfigurationChange, object: nil)
    }
}

//MARK: - collectionview delegate datasource
extension SettingViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //显示的风格个数
        return isShowIndex.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstrumentCellID, for: indexPath) as! InstrumentsCollectionCell
        //取出当前style
        var style:WoodenFishStyle
        style = woodenFishs[isShowIndex[indexPath.item]]
        cell.contentView.backgroundColor = style.backgroundColor
        cell.image = style.image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        config.styleIndex = isShowIndex[indexPath.item]
        
        saveConfiguration()
        //通知小组件
        GroupManager.shared.styleIndex = isShowIndex[indexPath.item]
        WidgetCenter.shared.reloadAllTimelines()
    }
    
}
