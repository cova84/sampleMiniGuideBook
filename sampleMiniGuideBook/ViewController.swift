//
//  ViewController.swift
//  sampleMiniGuideBook
//
//  Created by 小林由知 on 2017/11/09.
//  Copyright © 2017年 Yoshitomo Kobatashi. All rights reserved.
//

import UIKit

//1.プロトコルの設定（UITableViewDataSource,UITableViewDelegateの追加）
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    //選択されたエリア名を保存するメンバ変数
    var selectedName = ""
    
    //配列の中身は空にする
    var areList:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ファイルパスを取得（                                            エリア名が格納されているプロパティリスト）
        let filePath = Bundle.main.path(forResource: "areaList", ofType: "plist")
        
        //ファイルの内容を読み込んでディクショナリー型(文字列や数値をキーにして値を格納したり参照できる型)
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        //TableViemで扱いやすい配列の形（エリア名の入っている配列）
        for (key,data) in dic! {
            print(key)
            areList.append(key as! String)
        }
    }
    
    
    //2.行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areList.count
    }
    
    //3.表示する文字列を決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //文字列を表示するセルの取得
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath)
        
        //表示したい文字の設定
        cell.textLabel?.text = areList[indexPath.row]
        
        //文字を設定したいセルを返す
        return cell
        
    }
    
    
    //セルがタップされた時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //タップされた行のエリア名を保存
        //areList[indexPath.row]はタップされた行番号の情報
        selectedName = areList[indexPath.row]
        
        //セグエのidentifierを指定して、画面移動
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    //セグエを使って画面移動する時発動
    override func prepare(for segue:UIStoryboardSegue, sender:Any?){
        
        //次の画面のインスタンスを取得
        var dvc = segue.destination as! DetailViewController
        
        //次の画面のプロパティにタップされた行のエリア名を渡す
        dvc.getAreaName = selectedName
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

