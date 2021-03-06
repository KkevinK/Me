//
//  Store.swift
//  PokeMaster
//
//  Created by ruanjianyingyongbu on 2021/3/30.
//  Copyright © 2021 OneV's Den. All rights reserved.
//


import Combine

class Store: ObservableObject {
    @Published var appState = AppState()
    
    func dispatch(_ action: AppAction) {
        #if DEBUG
        print("[ACTION]: \(action)")
        #endif
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        if let command = result.1 {
            #if DEBUG
            print("[COMMAND]: \(command)")
            #endif
            command.execute(in: self)
        }
    }
    
    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?)
    {
        var appState = state
        var appCommand: AppCommand?
        switch action {
        case .login(let email, let password):
            //            if password == "password" {
            //                let user = User(email: email, favoritePokemonIDs: [])
            //                appState.settings.loginUser = user
            //            }
            guard !appState.settings.loginRequesting else {
                break
            }
            appState.settings.loginRequesting = true
            appCommand = LoginAppCommand(email: email, password: password)
            
        case .accountBehaviorDone(let result):
            appState.settings.loginRequesting = false
            switch result {
            case .success(let user):
                appState.settings.loginUser = user
            case .failure(let error):
                appState.settings.loginError = error
            }
            
        case .loadPokemons:
            if appState.pokemonList.loadingPokemons {
                break
            }
            appState.pokemonList.loadingPokemons = true
            appCommand = LoadPokemonsCommand()

        case .loadPokemonsDone(let result):
            switch result {
            case .success(let models):
                appState.pokemonList.pokemons = Dictionary(
                    uniqueKeysWithValues: models.map { ($0.id, $0) }
                )
            case .failure(let error):
                print(error)
            }
        }
        return (appState, appCommand)
    }
}
