//
//  ViewController.swift
//  iTunes-API-ios
//
//  Created by konojunya on 2018/01/24.
//  Copyright © 2018年 konojunya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - outlet
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - variables
    var musics = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.getMusics()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getMusics() {
    }
    
    //MARK: - tableView delegate method
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.musics.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        return cell
    }

}

