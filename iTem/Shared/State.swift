//
//  State.swift
//  iTem
//
//  Created by Dana Knowles on 5/10/22.
//

import Foundation
import ObservableStore

/// App state
struct State: Equatable {

}

extension AppState {
    /// State update function
    static func update(
        state: State,
        action: Intents,
        environment: Services
    ) -> Update<AppState, Intents> {
        switch action {
            //
        }
    }
}
