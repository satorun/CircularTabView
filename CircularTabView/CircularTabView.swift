import SwiftUI

struct CircularTabView: View {
    @State var selectionForContent = 0
    @State var selection = 0
    
    var viewProvider: any CircularTabContentViewProvider
    
    var body: some View {
        TabView(selection: $selection) {
            content(by: selectionForContent)
        }
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    @ViewBuilder
    func content(by current: Int) -> some View {
        let number = viewProvider.contentNumber
        let index = [
            (current-1+number)%number,
            current,
            (current+1+number)%number
        ]
        ForEach(0..<3) { i in
            AnyView(viewProvider.contentView(by: index[i]))
                .tag(index[i])
                .onDisappear {
                    selectionForContent = selection
                }
        }
    }
}

protocol CircularTabContentViewProvider {
    associatedtype SomeView: View
    
    var contentNumber: Int { get }
    func contentView(by index: Int) -> SomeView
}


#Preview {
    CircularTabView(viewProvider: PageViewProvider())
}
