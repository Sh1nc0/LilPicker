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
                .fill(LinearGradient(gradient: Gradient(colors: [gradient(m: 0), gradient(m: 1)]), startPoint: .leading, endPoint: .trailing))
                .frame(maxWidth: .infinity, maxHeight: 45)
                
            CustomButton()
                .offset(x: setOffestValue())
                .gesture(DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if abs(value.translation.width) < 0.1{
                            self.lastOffset = setOffestValue()
                        }
                        let sliderPos = max(-120, min(self.lastOffset + value.translation.width, 120))
                        self.value = String(Int(((sliderPos+120)*255)/240))
                        self.offset = setOffestValue()
                    })
                .animation(.spring())
        }
        
    }
    func setOffestValue()-> CGFloat{
        return CGFloat((((Int(self.value) ?? 0)*240)/255)-120)
    }
    func gradient(m: Double) -> Color{
        Color(red: (mode == 0) ? m : convert(value: r), green: (mode == 1) ? m : convert(value: g), blue: (mode == 2) ? m : convert(value: b))
    }
    
    func convert(value: String)->Double{
        return (Double(value) ?? 0)/255
    }
}

struct CustomButton: View{
 
    var body: some View{
        ZStack{
            Circle()
                .stroke(Color.white,lineWidth: 5)
                .foregroundColor(.clear)
                .frame(width: 40, height: 40)
            
        }
    }
}
