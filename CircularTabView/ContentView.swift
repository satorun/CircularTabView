import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            CircularTabView(viewProvider: PageViewProvider())
                .navigationTitle("CircularTabView")
        }
    }
}

#Preview {
    ContentView()
}
