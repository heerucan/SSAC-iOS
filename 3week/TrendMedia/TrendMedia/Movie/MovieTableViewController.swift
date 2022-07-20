//
//  MovieTableViewController.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/20.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    let movieList = MovieInfo()
//    [
//        Movie(title: "암살", releaseDate: "2022.11.23", runtime: 120, overview: "암살 줄거리", rate: 3.0),
//        Movie(title: "암살", releaseDate: "2022.11.23", runtime: 120, overview: "암살 줄거리", rate: 3.0),
//        Movie(title: "암살", releaseDate: "2022.11.23", runtime: 120, overview: "암살 줄거리", rate: 3.0)
//    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // MovieInfo().count 는 매번 불러올 때마다 메모리에 올리는 것임
        // 항상 인스턴스를 만드는 것임
        return movieList.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let data = movieList.movie[indexPath.row]
        cell.configureCell(data: data)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
}
