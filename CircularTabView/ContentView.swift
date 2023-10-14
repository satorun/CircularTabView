import SwiftUI

struct ContentView: View {

    var body: some View {
        CircularTabView(viewProvider: PageViewProvider())
    }
}

#Preview {
    ContentView()
}
