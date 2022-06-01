//
//  SplitView.swift
//  iTem
//
//  Created by Dana Knowles on 6/1/22.
//

import SwiftUI

struct SplitView<PrimaryView: View, SecondaryView: View>: View {

    enum SplitViewStatus {
        case closed
        case half
        case full
    }
    // MARK: Props

    @GestureState private var offset: CGFloat = 0
    @State private var storedOffset: CGFloat = 0
    @State var status: SplitViewStatus = .closed
    
    let primaryView: PrimaryView
    let secondaryView: SecondaryView


    // MARK: Initilization

    init(
        @ViewBuilder top: @escaping () -> PrimaryView,
        @ViewBuilder bottom: @escaping () -> SecondaryView)
    {
        self.primaryView = top()
        self.secondaryView = bottom()
    }


    // MARK: Body
    
    func isInSafeZone(point: CGPoint, inRect: CGRect) -> Bool {
        let librarySafeZone = 0.0
        let spaceSafeZone = 100.0
        let maxY = inRect.maxY - librarySafeZone
        let minY = inRect.minY + spaceSafeZone
        guard point.y < maxY && point.y > minY else { return false }
        return true
    }
    
    func newStatus(point: CGPoint, inRect: CGRect) -> SplitViewStatus {
/*
            where does the
 */
        
//        switch status {
//        case .closed:
//
//        case .full:
//        case .half:
//        }
        print(point.y / inRect.maxY)
        switch point.y / inRect.maxY {
        case 0...0.4: return .full
        case 0.4...0.6: return .half
        default: return .closed
        }
        
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                self.primaryView
                    .frame(height: (proxy.size.height / 2) + self.totalOffset)
                    .zIndex(1)

                self.handle
                    .gesture(
                        DragGesture(coordinateSpace: .global)
                            .updating(self.$offset, body: { value, state, _ in
                                guard isInSafeZone(point: value.location, inRect: proxy.frame(in: .global)) else { return }
                                withAnimation(.spring()) {
                                    state = value.translation.height
                                }
                            })
                            .onEnded { value in
                                guard isInSafeZone(point: value.location, inRect: proxy.frame(in: .global)) else { return }
                                // set to a new status
                                //self.storedOffset += value.translation.height
                                let topOffset = 100.0
                                let bottomOffset = 30.0

                                
                                withAnimation(.spring()) {
                                    switch newStatus(point: value.location, inRect: proxy.frame(in: .global)) {
                                    case .closed: self.storedOffset = proxy.size.height / 2 - bottomOffset
                                    case .half: self.storedOffset = 0
                                    case .full: self.storedOffset = (-proxy.size.height / 2) + topOffset
                                    }
                                }
                                //print(self.storedOffset)
                            }
                    )
                    //.offset(y: self.offset)
                    .zIndex(0)

                self.secondaryView.zIndex(1)
                    
            }
        }
    }


    // MARK: Computed Props

    var handle: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 44, height: 5)
            .foregroundColor(Color.gray)
            .padding(5)
            .contentShape(Rectangle())
    }

    var totalOffset: CGFloat {
        storedOffset + offset
    }
}

