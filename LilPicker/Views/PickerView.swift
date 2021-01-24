//
//  PickerView.swift
//  LilPicker
//
//  Created by Romain Pipon on 23/01/2021.
//

import SwiftUI

struct PickerView: View {
    @State var red: String = "0"
    @State var green: String = "0"
    @State var blue: String = "0"
    
    var body: some View {
        NavigationView{
            VStack(spacing: 15){
                Spacer()
                Section(header: HStack{
                    Text("RED").foregroundColor(.gray).font(.system(size: 18, weight: .bold)).padding(.horizontal, 15)
                    Spacer()
                }){
                    HStack(spacing: 15){
                        Selector(value: $red,mode: 0, r: $red, g: $green, b: $blue)
                                .padding(.leading, 15)
                        TextField("0", text: $red, onEditingChanged: { (ended) in
                            if(!ended){
                                self.red = (Int(self.red) ?? 0) > 255 ? "255" : self.red
                            }
                        }).modifier(CustomTextField())
                    }
                }
                Section(header: HStack{
                    Text("GREEN").foregroundColor(.gray).font(.system(size: 18, weight: .bold)).padding(.horizontal, 15)
                    Spacer()
                }){
                    HStack(spacing: 15){
                        Selector(value: $green, mode: 1,r: $red, g: $green, b: $blue)
                                .padding(.leading, 15)
                        
                        TextField("0", text: $green, onEditingChanged: { (ended) in
                            if(!ended){
                                self.green = (Int(self.green) ?? 0) > 255 ? "255" : self.green
                            }
                        }).modifier(CustomTextField())

                    }
                }
                Section(header: HStack{
                    Text("BLUE").foregroundColor(.gray).font(.system(size: 18, weight: .bold)).padding(.horizontal, 15)
                    Spacer()
                }){
                    HStack(spacing: 15){
                        Selector(value: $blue, mode: 2, r: $red, g: $green, b: $blue)
                                .padding(.leading, 15)
                        TextField("0", text: $blue, onEditingChanged: { (ended) in
                            if(!ended){
                                self.blue = (Int(self.blue) ?? 0) > 255 ? "255" : self.blue
                            }
                        }).modifier(CustomTextField())
                    }
                }
                Spacer()
                Divider()
                HStack(spacing: 10){
                    RoundedRectangle(cornerRadius: 20).frame(width: 100,height: 100)
                        .foregroundColor(Color(red:convert(value: red), green: convert(value: green), blue: convert(value: blue), opacity: 1)).padding(.horizontal, 15)
                    Spacer()
                }
                Spacer()
                
            }.navigationBarTitle(Text("Color Picker"))
            
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    func convert(value: String)->Double{
        return (Double(value) ?? 0)/255
    }
}

struct CustomTextField: ViewModifier{
    func body(content: Content) -> some View{
        return content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .accentColor(.black)
            .font(.system(size: 18, weight: .bold))
            .frame(width: 85, height: 45)
            .background(Color(#colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.trailing, 15)
        
    }
}
