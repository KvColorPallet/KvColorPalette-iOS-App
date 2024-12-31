//
//  CommonUI.swift
//  kv-ios-color-pallet-app
//
//  Created by Kavimal Wijewardana on 12/30/24.
//
import SwiftUI
import kv_ios_color_pallet

public struct ColorBox: View {
    
    @State private var showBorder = false
    
    private var givenColor: Color = .blue
    private var selectedColor: Color? = nil
    private var onSelect: (Color) -> Void
    
    public init (givenColor: Color, selectedColor: Color? = nil, onSelect: @escaping (Color) -> Void) {
        self.givenColor = givenColor
        self.selectedColor = selectedColor
        self.onSelect = onSelect
    }
    
    public var body: some View {
        Rectangle()
            .fill(givenColor)
            .frame(width: 32, height: 32)
            .border(showBorder ? Color.white : .clear, width: 2)
            .onTapGesture {
                showBorder.toggle()
                onSelect(givenColor)
            }
            .onAppear {
                if let selectedColor {
                    if ColorUtil.getHexWithAlpha(color: selectedColor) == ColorUtil.getHexWithAlpha(color: givenColor) {
                        showBorder.toggle()
                    }
                }
            }
    }
}

public struct ColorDetailRow: View {
    
    private var selectedColor: Color
    
    public init(selectedColor: Color) {
        self.selectedColor = selectedColor
    }
    
    public var body: some View {
        HStack {
            Rectangle()
                .fill(selectedColor)
                .frame(width: 50, height: 50)
                .border(Color.black, width: 1)
                .padding(8)
            
            VStack {
                HStack {
                    Text("HEX: ")
                    Text("\(ColorUtil.getHex(color: selectedColor))")
                }
                
                HStack {
                    Text("HEX with Alpha: ")
                    Text("\(ColorUtil.getHexWithAlpha(color: selectedColor))")
                }
            }
        }
        .padding(8)
        .background(Color.white)
        //.shadow(radius: 3)
    }
}

#Preview {
    ColorBox(givenColor: Color.blue, onSelect: { _ in })
    ColorDetailRow(selectedColor: .red)
}
