import SwiftUI

struct ListView: View {
    var color: Color
    var resetScrollView: Bool = true

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
                if resetScrollView {
                    // In the case of CircularTabView:
                    // When switching tabs, the scroll position of the previously viewed tab is retained.
                    // As a minimum countermeasure, reset it to return to the top.
                    //
                    // In the case of LinearTabView:
                    // The scroll position can be accurately maintained for about three tabs,
                    // but when switching beyond that, the scroll position of another tab is reflected.
                    // It is presumed that this occurs because internally, the View maintains the state
                    // for about three tabs and that state is being applied.
                    proxy.scrollTo(0)
                }
            }
        }
    }
}

struct ListViewProvider: TabContentViewProvider {
    var resetScrollView: Bool = true
    
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
        ListView(color: contentsData[index].1, resetScrollView: resetScrollView)
    }
    
    
}

#Preview {
    ListView(color: .blue)
}
