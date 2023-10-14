import SwiftUI

struct CircularTabView: View {
    @State var selectionForContent = 0
    @State var selection = 0
    
    @State var indicatorPosition: CGFloat = 0.0
    @State var indicatorWidth: CGFloat = 0.0
    @State var widthDic: [String: CGFloat] = [:]
    
    func indicatorOffsetBase(at index: Int) -> CGFloat {
        var offset: CGFloat = 0.0
        for i in 0..<index {
            offset += widthDic["\(i)"] ?? 0.0
        }
        return offset
    }
    
    var viewProvider: any CircularTabContentViewProvider
    
    var body: some View {
        VStack(spacing: .zero) {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    let indicatorHeight = CGFloat(4.0)
                    VStack(alignment: .leading) {
                        HStack(spacing: .zero) {
                            ForEach(0..<5) { i in
                                Button {
                                    withAnimation {
                                        selection = i%5
                                    }
                                } label: {
                                    Text("label \(i+1)")
                                        .foregroundColor(selection == i ? .black : .gray)
                                }
                                .padding(.horizontal, 30)
                                .id(i)
                                .overlay {
                                    GeometryReader { geometry in
                                        Color.clear
                                            .onAppear {
                                                widthDic["\(i)"] = geometry.size.width
                                                guard selection == i else { return }
                                                indicatorWidth = geometry.size.width
                                            }
                                            .onChange(of: selection) { _, newValue in
                                                guard selection == i else { return }
                                                indicatorWidth = geometry.size.width
                                            }
                                    }
                                }
                            }
                        }
                        Rectangle()
                            .frame(width: indicatorWidth, height: indicatorHeight)
                            .offset(.init(width: indicatorOffsetBase(at: selection) - indicatorPosition * indicatorWidth , height: .zero))
                            
                    }
                }
                .onChange(of: selection) { _, newValue in
                    withAnimation {
                        proxy.scrollTo(newValue)
                    }
                }
            }
            TabView(selection: $selection) {
                content(by: selectionForContent)
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
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
                .overlay {
                    GeometryReader { proxy in
                        Color.clear
                            .onChange(of: proxy.frame(in: .global)) { oldValue, newValue in
                                guard index[i] == selection else { return }
                                indicatorPosition = newValue.origin.x/newValue.width
                            }
                    }
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
