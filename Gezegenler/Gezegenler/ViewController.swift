//
//  ViewController.swift
//  Gezegenler
//
//  Created by SUNGU on 9.05.2022.
//

import UIKit

struct Group {
    let title: String
    let gezegens : [String]
}

final class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    private let gezegens: [String: [String]] = [
        "D": ["Dunya"],
        "E": ["Epsilon Reticuli A"],
        "F": ["Fluton"],
        "K": ["Kepler-9"],
        "G": ["Gliese 436","Gliese 86 A"],
        "L": ["Lupus-TR-3"],
        "M": ["Mars","Merkur"],
        "N": ["Neptun"],
        "P": ["Pluton"],
        "J": ["Jupıter"],
        "S": ["Saturn"],
        "V": ["Venus"],
        "U": ["Uranus"],
        ]
    
    private let alphabet = "abcdefghijklmnorstuvwxyz"
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var models = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUpData() {
        for (key,value) in gezegens {
            models.append(Group(title: key, gezegens: value))
        }
        models = models.sorted(by: { $0.title < $1.title})
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect (x: 0, y: view.safeAreaInsets.top, width: view.frame.size.width,
                                  height: view.frame.size.height-view.safeAreaInsets.top)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].gezegens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = models[indexPath.section].gezegens[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return models[section].title
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return Array(alphabet.uppercased()).compactMap({"\($0)"})
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let targetIndex = models.firstIndex(where: {$0.title == title}) else {
            return 0
        }
        return targetIndex
    }
    
}

