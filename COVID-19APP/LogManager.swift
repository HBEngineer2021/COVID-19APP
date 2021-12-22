//
//  LogManager.swift
//  COVID-19APP
//
//  Created by Motoki Onayama on 2021/12/17.
//

import Foundation

class LogManager {
    static var shared = LogManager()
    
    /// ファイル名
    let fileName = "log.txt"
    
    let contents = "ファイルの生成に成功"
    
    let fileManager = FileManager.default
    
    var log: String?
    
    /// ファイルを生成
    func createFile() {
        
        guard let fileUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        /// 保存先パスを生成
        let file = fileUrl.appendingPathComponent(fileName)
        
        print(file)
        
        let existFile = FileManager.default.fileExists(atPath: file.path)
        
        guard !existFile else { return }
        
        let createFile = fileManager.createFile(atPath: file.path, contents: contents.data(using: .utf8), attributes: .none)
        
        guard createFile else { return print("ファイル生成に失敗しました。") }
    }
    
    /// ファイルに書き込む
    func write() {
        
        guard let fileUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        /// 保存先パスを生成
        let file = fileUrl.appendingPathComponent(fileName)
        
        guard let fileHandle = FileHandle(forWritingAtPath: file.path) else { return }
        
        guard let contentData = log!.data(using: .utf8) else { return }
        
        fileHandle.seekToEndOfFile()
        
        fileHandle.write(contentData)
        
        fileHandle.closeFile()
    }
    
    /// ログ出力
    /// - Parameters:
    ///   - object: 処理やコメントを記載
    ///   - function: 処理中の関数
    ///   - line: 処理中の行数
    /// - Returns: 変数logで返す
    func printer(object: Any, function: String = #function, line: Int = #line) -> String {
        print("[function:\(function) line:\(line)] \(object)")
        log = "\n[function:\(function) line:\(line)] \(object)\n"
        return log!
    }
}
