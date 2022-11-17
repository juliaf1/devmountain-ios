//
//  ViewController.swift
//  Pokedex
//
//  Created by Julia Frederico on 11/11/22.
//

import UIKit

class PokemonViewController: UIViewController {

    // MARK: - Properties and outlets

    var pokemonTypes: [PokemonType] = [] {
        didSet {
            pokemonTypesTableView.reloadData()
        }
    }

    var pokemonType: PokemonType?
    
    @IBOutlet weak var pokemonTypesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIdLabel: UILabel!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonTypesTableView.delegate = self
        pokemonTypesTableView.dataSource = self
        searchBar.delegate = self
        
        fetchPokemonTypes()
    }
    
    // MARK: - Methods
    
    func fetchSpriteAndUpdateViews(pokemon: Pokemon) {
        PokemonController.fetchSprite(pokemon: pokemon) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.pokeImageView.image = image
                    self.pokeNameLabel.text = pokemon.name.capitalized
                    self.pokeIdLabel.text = "ID: \(pokemon.id)"
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    func fetchPokemonTypes() {
        PokemonTypeController.fetchAllPokemonTypes { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let types):
                    self.pokemonTypes = types
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }

}

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let searchTerm = searchBar.text,
              !searchTerm.isEmpty else { return }
        
        PokemonController.fetchPokemon(searchTerm: searchTerm) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateViews(pokemon: pokemon)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
}

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokeTypeCell", for: indexPath) as? PokemonTypeTableViewCell else { return UITableViewCell() }

        let type = pokemonTypes[indexPath.row]
        cell.type = type

        return cell
    }
    
}
