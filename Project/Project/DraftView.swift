//
//  DraftView.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import SwiftUI

struct DraftView: View {
    @ObservedObject var gameVM = GameViewModel()
    var body: some View {
        VStack{
            Text("Draft:")
                .bold()
                .onAppear {
                    gameVM.addummy()
                }
            Spacer()
                    ZStack{
                        Rectangle ()
                            .fill(Color.white)
                            .frame(width: 350, height: 270)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10) // Ensures the stroke also has rounded corners
                                    .stroke(Color.black, lineWidth: 0.5) // Black stroke
                            )
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 2, y: 4)
                            .padding(10)
                        
                        VStack {

                            Text("        Team                        Record     SOS")
                                .foregroundColor(.black)
                                .frame(width: 320)
                                .bold()
                            Spacer()
                                .frame(height: 13)
                            ScrollView{
                                ForEach(gameVM.draftteams, id: \.self) { index in
                                    HStack {
                                        Image(index.name) // Replace with your image name
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 32, height: 32)
                                        Text(index.name)
                                            .frame(maxWidth: 150, alignment: .leading)
                                        Text(index.winloss)
                                            .padding(.trailing, 35)
                                        Text(index.sos)
                                    }
                                    Spacer()
                                        .frame(height: 5)
                                
                            }
                        }
                            .frame(width: 350, height: 220)
                        }
                
            }
            Spacer()
                .frame(height: 30)
            Text("Big Board:")
                .multilineTextAlignment(.leading)
                .bold()
            Spacer()
                                ZStack{
                                    Rectangle ()
                                        .fill(Color.white)
                                        .frame(width: 350, height: 270)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10) // Ensures the stroke also has rounded corners
                                                .stroke(Color.black, lineWidth: 0.5) // Black stroke
                                        )
                                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 2, y: 4)
                                        .padding(10)
                                    
                                    VStack {

                                        Text("Player            School         Position")
                                            .foregroundColor(.black)
                                            .frame(width: 320)
                                            .bold()
                                        Spacer()
                                            .frame(height: 13)
                                        ScrollView{
                                            ForEach(gameVM.bigboards, id: \.self) { index in
                                                HStack {
                                                    Image(index.name) // Replace with your image name
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 50, height: 32)
                                                    
                                                    Text(index.name)
                                                        .frame(maxWidth: 200, alignment: .leading)
                                                    Text(index.position)
                                                        .frame(alignment: .leading)
                                                    Spacer()
                                                    Text(index.school)
                                                        .frame(maxWidth: 180, alignment: .leading)
                                                }
                                                Spacer()
                                                    .frame(height: 10)
                                            
                                        }
                                    }
                                        .frame(width: 350, height: 220)
                                    }
                            
                        }
            Spacer()
                .frame(height: 40)
        }
    }
}

#Preview {
    DraftView()
}
