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
    var contentsData: [Color] = [
        .blue,
        .green,
        .yellow,
        .purple,
        .red
    ]
    
    var contentNumber: Int {
        contentsData.count
    }
    
    func contentView(by index: Int) -> some View {
        PageView(color: contentsData[index])
    }
}

#Preview {
    PageView(color: .blue)
}
