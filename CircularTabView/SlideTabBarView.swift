//
//  SlideTabBarView.swift
//  CircularTabView
//
//  Created by Satoru Nishimura on 2023/10/14.
//

import SwiftUI

struct SlideTabBarView: View {
    @Binding var selection: Int
    @Binding var indicatorPosition: CGFloat
    
    var viewProvider: any TabContentViewProvider
    
    var primaryColor: Color = .black
    var secondaryColor: Color = .gray
    var animated: Bool = false
    
    @State private var indicatorWidth: CGFloat = 0.0
    @State private var widthDic: [String: CGFloat] = [:]
        
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                let indicatorHeight = CGFloat(4.0)
                VStack(alignment: .leading) {
                    HStack(spacing: .zero) {
                        ForEach(0..<viewProvider.contentNumber, id: \.self) { i in
                            Button {
                                if animated {
                                    withAnimation {
                                        selection = i
                                    }
                                } else {
                                    selection = i
                                }
                            } label: {
                                Text(viewProvider.label(by: i))
                                    .foregroundColor(selection == i ? primaryColor : secondaryColor)
                                    .padding(.horizontal)
                            }
                            .id(i)
                            .overlay {
                                GeometryReader { geo in
                                    Color.clear
                                        .onAppear {
                                            widthDic["\(i)"] = geo.size.width
                                            guard selection == i else { return }
                                            indicatorWidth = geo.size.width
                                        }
                                        .onChange(of: selection) { _, newValue in
                                            guard selection == i else { return }
                                            indicatorWidth = geo.size.width
                                        }
                                }
                            }
                        }
                    }
                    Rectangle()
                        .foregroundColor(primaryColor)
                        .frame(width: indicatorWidth, height: indicatorHeight)
                        .offset(.init(
                            width: indicatorOffsetBase(at: selection) - indicatorPosition * indicatorWidth,
                            height: .zero))
                }
            }
            .onChange(of: selection) { _, newValue in
                withAnimation {
                    proxy.scrollTo(newValue)
                }
            }
        }
    }
    
    func indicatorOffsetBase(at index: Int) -> CGFloat {
        var offset: CGFloat = 0.0
        for i in 0..<index {
            offset += widthDic["\(i)"] ?? 0.0
        }
        return offset
    }
}

#Preview {
    SlideTabBarView(selection: .constant(0), indicatorPosition: .constant(0.0), viewProvider: PageViewProvider(), primaryColor: .blue)
}
