import SwiftUI

struct LinearTabView: View {
    @State var selectionForContent = 0
    @State var selection = 0
    
    @State var indicatorPosition: CGFloat = 0.0
    
    var viewProvider: any TabContentViewProvider
    
    var body: some View {
        VStack(spacing: .zero) {
            SlideTabBarView(
                selection: $selection,
                indicatorPosition: $indicatorPosition,
                viewProvider: viewProvider
            )
                .ignoresSafeArea(edges: .horizontal)
            TabView(selection: $selection) {
                ForEach(0..<viewProvider.contentNumber, id: \.self) { i in
                    AnyView(viewProvider.contentView(by: i))
                        .tag(i)
                        .onDisappear {
                            selectionForContent = selection
                        }
                        .overlay {
                            GeometryReader { proxy in
                                Color.clear
                                    .onChange(of: proxy.frame(in: .global)) { _, newValue in
                                        guard i == selection else { return }
                                        indicatorPosition = (newValue.origin.x)/newValue.width
                                    }
                            }
                        }
                }
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
    
    func index(by current: Int) -> [Int] {
        let number = viewProvider.contentNumber
        return [
            (current-1+number)%number,
            current,
            (current+1+number)%number
        ]
    }
}

#Preview {
    LinearTabView(viewProvider: PageViewProvider())
}
