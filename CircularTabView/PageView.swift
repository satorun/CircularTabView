import SwiftUI

struct PageView: View {
    var color: Color
    
    var body: some View {
        ZStack {
            color.ignoresSafeArea()
            Text("Page \(color.description)")
        }
    }
}


struct PageViewProvider: CircularTabContentViewProvider {
    
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
        PageView(color: contentsData[index].1)
    }
}

#Preview {
    PageView(color: .blue)
}
