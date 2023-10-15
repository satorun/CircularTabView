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
            }
            .navigationTitle("View Samples")
        }
    }
}

#Preview {
    ContentView()
}
