//
//  SessionsViewModel.swift
//  Steamo
//
//  Created by Max Kraev on 26.11.2019.
//  Copyright © 2019 Max Kraev. All rights reserved.
//

import UIKit

class SessionsViewModel: NSObject {
    
    private let networkAdapter: Networking
    
    fileprivate var games: Games?
    
    init(networkAdapter: Networking) {
        self.networkAdapter = networkAdapter
    }
    
    func loadRecentlyPlayedGames(completion: @escaping ((Swift.Result<Void, SteamoError>) -> Void)) {
        networkAdapter.recentlyPlayedGames { [weak self] result in
            switch result {
            case let .success(games):
                self?.games = games
                completion(.success(()))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

extension SessionsViewModel: UITableViewDelegate {
    
}

extension SessionsViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games?.response.totalCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let game = games?.response.games[indexPath.row],
              let cell: TableCellContainer<GameView> = tableView.dequeue(indexPath: indexPath) else {
            return UITableViewCell()
        }
        cell.containedView.configure(with: game)
        
        return cell
    }
}
