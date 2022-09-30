// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

import SwiftUI

struct AccountListView: View {
    @EnvironmentObject private var model: GlobalModel
    @State private var selectedAccount: Account?

    var body: some View {
        ScrollViewReader { _ in
            List {
                ForEach($model.accounts) { $account in
                    NavigationLink(tag: account, selection: $selectedAccount) {
                        AccountView(account: $account)
                    } label: {
                        AccountRow(account: $account).padding(.vertical, 8).accessibilityIdentifier(account.displayName)
                    }
                }
            }
            .accessibilityRotor("Accounts", entries: model.accounts, entryLabel: \.displayName)
            .refreshable(action: {
                await model.refreshAccounts()
            })
        }
        .navigationTitle(Text("Accounts"))
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AccountListView().environmentObject(GlobalModel.buildForPreview())
        }
    }
}
