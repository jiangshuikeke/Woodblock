//
//  UserModel.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/29.
//

import Foundation

class UserModel:ObservableObject{
    @Published var config:Config = load("Config.json")
    @Published var isShowStyles:[Bool] = load("isShowStyle.json")
    func saveConfig(){
        save("Config.json", T: config)
    }
    
    func saveStyles(){
        save("isShowStyle.json", T: isShowStyles)
    }
}



func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func save(_ filename:String,T:Encodable){
    //保存路径
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do{
        let data = try JSONEncoder().encode(T)
        try data.write(to: file)
    }catch let error{
        print(error)
    }
}

