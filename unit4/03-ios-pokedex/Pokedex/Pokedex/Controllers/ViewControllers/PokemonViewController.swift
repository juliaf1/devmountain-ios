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

    var selectedPokemonType: PokemonType?
    
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
    
    func fetchRandomPokemonForSelectedType() {
        guard let selectedPokemonType = selectedPokemonType else {
            return
        }

        PokemonController.fetchPokemons(of: selectedPokemonType) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokeInfoList):
                    guard let randomPokeInfo = pokeInfoList.randomElement() else { return }
                    self.fetchPokemon(for: randomPokeInfo)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    func fetchPokemon(for pokeInfo: PokemonInfo) {
        PokemonController.fetchPokemon(url: pokeInfo.data.url) { result in
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
        cell.updateView(with: type, isSelected: selectedPokemonType == type)
        cell.delegate = self

        return cell
    }
    
}

extension PokemonViewController: PokemonTypeTableViewCellDelegate {
    
    func didSelectPokemonType(for cell: PokemonTypeTableViewCell) {
        guard let indexPath = pokemonTypesTableView.indexPath(for: cell) else { return }
        let type = pokemonTypes[indexPath.row]
        
        if selectedPokemonType == type {
            selectedPokemonType = nil
        } else {
            selectedPokemonType = type
        }

        pokemonTypesTableView.reloadData()
        fetchRandomPokemonForSelectedType()
    }
    
}
