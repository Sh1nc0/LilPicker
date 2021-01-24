//
//  Selector.swift
//  LilPicker
//
//  Created by Romain Pipon on 23/01/2021.
//

import SwiftUI

struct Selector: View {
    @Binding var value: String
    @State var mode: Int
    @Binding var r: String
    @Binding var g: String
    @Binding var b: String
  
    @State private var offset: CGFloat = -120
    @State private var lastOffset: CGFloat = 0
    
       
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 22.5)
                .fill(LinearGradient(gradient: Gradient(colors: [
                                            Color(red: (mode == 0) ? 0 : convert(value: r), green: (mode == 1) ? 0 : convert(value: g), blue: (mode == 2) ? 0 : convert(value: b)),
                                            Color(red: (mode == 0) ? 1 : convert(value: r), green: (mode == 1) ? 1 : convert(value: g), blue: (mode == 2) ? 1 : convert(value: b))]), startPoint: .leading, endPoint: .trailing))
                .frame(maxWidth: .infinity, maxHeight: 45)
                
            CustomButton()
                .offset(x: CGFloat((((Int(value) ?? 0)*240)/255)-120))
                .gesture(DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if abs(value.translation.width) < 0.1{
                            self.lastOffset = CGFloat((((Int(self.value) ?? 0)*240)/255)-120)
                        }
                        let sliderPos = max(-120, min(self.lastOffset + value.translation.width, 120))
                        
                        self.value = String(Int(((sliderPos+120)*255)/240))
                        self.offset = CGFloat((((Int(self.value) ?? 0)*240)/255)-120)
                    }
                
                )
                
                .animation(.spring())
        }
        
    }
    func convert(value: String)->Double{
        return (Double(value) ?? 0)/255
    }
}

struct CustomButton: View{
 
    var body: some View{
        ZStack{
            Circle()
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
            Circle().frame(width: 35, height: 35)
        }
    }
}
