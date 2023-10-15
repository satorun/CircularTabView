import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            List {
                let labelCP = "CircularTabView - PageView"
                NavigationLink {
                    CircularTabView(viewProvider: PageViewProvider())
                        .navigationTitle(labelCP)
                } label: {
                    Text(labelCP)
                }
                let labelCL = "CircularTabView - ListViewProvider"
                NavigationLink {
                    CircularTabView(viewProvider: ListViewProvider())
                        .navigationTitle(labelCL)
                } label: {
                    Text(labelCL)
                }
                let labelLP = "LinearTabView - PageView"
                NavigationLink {
                    LinearTabView(viewProvider: PageViewProvider())
                        .navigationTitle(labelLP)
                } label: {
                    Text(labelLP)
                }
                let labelLL = "LinearTabView - ListViewProvider"
                NavigationLink {
                    LinearTabView(viewProvider: ListViewProvider(resetScrollView: false))
                        .navigationTitle(labelLL)
                } label: {
                    Text(labelLL)
                }
            }
            .navigationTitle("View Samples")
        }
    }
}

#Preview {
    ContentView()
}
