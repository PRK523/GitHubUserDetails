//
//  GitApiViewController.swift
//  GitHubApplication
//
//  Created by PRANOTI KULKARNI on 12/21/20.
//
import UIKit

class GitApiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private enum Constants {
        static let customCellName = "GitApiCustomCell"
        static let tableHeaderTitle = "GitHub Api Details"
        static let url = "https://api.github.com/repos/eficode/weatherapp/commits"
        static let error = "Error fetching response"
        static let cellHeight: CGFloat = 45.0
        static let headerFontSize: CGFloat = 20
    }
    
    @IBOutlet weak private var tableView: UITableView?
    
    private var users = [UserData]()
    
    override func viewDidLoad() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.parse()
        self.registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        let nib = UINib(nibName: Constants.customCellName,
                                  bundle: nil)
        self.tableView?.register(nib, forCellReuseIdentifier: Constants.customCellName)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customCellName) as! GitApiCustomCell
        cell.authorName.text = users[indexPath.row].authorName
        cell.commitMessage.text = users[indexPath.row].commitMessage
        cell.commitSha.text = users[indexPath.row].commitSHA
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.tableHeaderTitle
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .boldSystemFont(ofSize: Constants.headerFontSize)
    }
}

extension GitApiViewController {
    private func parse() {
        guard let url = URL(string: Constants.url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let userArray = try decoder.decode([UserData].self, from: data)
                    self.users = userArray
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            } catch let err {
                print(Constants.error, err)
            }
        }.resume()
    }
    
}
