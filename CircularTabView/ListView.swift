import SwiftUI

struct ListView: View {
    var color: Color

    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                List {
                    ForEach(0..<100) { i in
                        Text("Row \(i+1)")
                            .listRowBackground(color)
                            .id(i)
                    }
                }
                .listStyle(.plain)
            }
            .onAppear {
                // When switching tabs, the scroll position of the previously viewed tab is retained.
                // As a minimum countermeasure, reset it to return to the top.
                proxy.scrollTo(0)
            }
        }
        
    }
}

struct ListViewProvider: CircularTabContentViewProvider {
    
    var contentsData: [(String, Color)] = [
        ("Label Blue", .blue),
        ("Label Green", .green),
        ("Label Yellow", .yellow),
        ("Label Purple", .purple),
        ("Label Red", .red)
    ]
    
    var contentNumber: Int {
        contentsData.count
    }
    
    func label(by index: Int) -> String {
        contentsData[index].0
    }
    
    func contentView(by index: Int) -> some View {
        ListView(color: contentsData[index].1)
    }
    
    
}

#Preview {
    ListView(color: .blue)
}
