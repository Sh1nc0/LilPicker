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
                    barComponent(value: $red, mode: 0, r: $red, g: $green, b: $blue)
                }
                Section(header: HStack{
                    Text("GREEN").foregroundColor(.gray).font(.system(size: 18, weight: .bold)).padding(.horizontal, 15)
                    Spacer()
                }){
                    barComponent(value: $green, mode: 1, r: $red, g: $green, b: $blue)
                }
                Section(header: HStack{
                    Text("BLUE").foregroundColor(.gray).font(.system(size: 18, weight: .bold)).padding(.horizontal, 15)
                    Spacer()
                }){
                    barComponent(value: $blue, mode: 2, r: $red, g: $green, b: $blue)
                }
                Spacer()
                Divider()
                HStack{
                    Button(action: {}){
                        Image(systemName: "plus.circle.fill").font(.system(size: 30))
                    }
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 15){
                            ForEach((0...9), id: \.self){ i in
                                Circle().frame(width: 30,height: 30)
                            }
                        }
                    }
                }.padding([.leading, .top], 15)
                RoundedRectangle(cornerRadius: 20).frame(maxWidth: .infinity,maxHeight: 100)
                    .foregroundColor(Color(red:convert(value: red), green: convert(value: green), blue: convert(value: blue), opacity: 1)).padding(.horizontal, 15).padding(.top, 10)
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
struct barComponent: View {
    @Binding var value: String
    @State var mode: Int
    @Binding var r: String
    @Binding var g: String
    @Binding var b: String
    var body: some View{
        HStack(spacing: 15){
            Selector(value: $value, mode: mode, r: $r, g: $g, b: $b)
                .padding(.leading, 15)
                

            TextField("0", text: $value,onEditingChanged: { (ended) in
                if(!ended){
                    self.value = (Int(self.value) ?? 0) > 255 ? "255" : self.value
                }
            }).modifier(CustomTextField())
        }
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
            .background(Color("Gray"))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.trailing, 15)
        
    }
}
private class TextFieldObserver: NSObject {
    @objc
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectAll(nil)
    }
}
