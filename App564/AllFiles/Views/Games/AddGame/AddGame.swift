//
//  AddGame.swift
//  App564
//
//  Created by DJUROM on 03/06/2024.
//

import SwiftUI

struct AddGame: View {

    @StateObject var viewModel: GamesViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Add a class")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                        .padding()
                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 18, weight: .regular))
                            
                            Text("Back")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 16, weight: .regular))
                        })
                        
                        Spacer()
                    }
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {

                        ZStack(alignment: .leading, content: {
                            
                            Text("Name")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.gName.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.gName)
                                .foregroundColor(Color.black)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Description")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.gDescription.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.gDescription)
                                .foregroundColor(Color.black)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white))

                        ZStack(alignment: .leading, content: {
                            
                            Text("Rules")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.gRules.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.gRules)
                                .foregroundColor(Color.black)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white))

                    }
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.prizes, id: \.self) { index in
                            
                                HStack {
                                    
                                    Image(index.prPhoto ?? "")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50)
                                        .padding(5)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                                    
                                    VStack(alignment: .leading, spacing: 12) {
                                        
                                        Text(index.prName ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .semibold))
                                        
                                        Text(index.prDescription ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 14, weight: .regular))
                                    }
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))
                                .padding()
                            }
                        }
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddPrize = true
                            }
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "plus")
                                    .foregroundColor(Color("primary"))
                                    .font(.system(size: 16, weight: .medium))
                                
                                Text("Add a prize")
                                    .foregroundColor(Color("primary"))
                                    .font(.system(size: 14, weight: .regular))
                            }
                            .padding(12)
                            .padding(.horizontal)
                   
                        })
                    }
                }
                
                Button(action: {
                    
                    viewModel.addGame()
                    
                    viewModel.gName = ""
                    viewModel.gDescription = ""
                    viewModel.gRules = ""
                    
                    viewModel.fetchGames()
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = false
                    }
                    
                }, label: {

                    Text("Add")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                })
        
            }
            .padding()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddPrize ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddPrize = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddPrize = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Add a prize")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                    
                    Menu(content: {
                        
                        ForEach(viewModel.photos, id: \.self) { index in
                            
                            Button(action: {
                                
                                viewModel.currentPhoto = index
                                
                            }, label: {
                                
                                Image(index)
                            })
                            
                        }
                        
                    }, label: {
                        
                        if viewModel.currentPhoto.isEmpty {
                            
                            Image(systemName: "photo")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 40))
                                .padding(70)
                                .background(RoundedRectangle(cornerRadius: 25).stroke(Color("primary")))
                            
                        } else {
                            
                            Image(viewModel.currentPhoto)
                        }
                        
                    })
                    .padding(.bottom)
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Name")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.prName.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.prName)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .semibold))
                        
                    })
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("primary")))
                    .padding(1)
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Description")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.prDescription.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.prDescription)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .semibold))
                        
                    })
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("primary")))
                    .padding(1)
                    .padding(.bottom)
                    
                    HStack {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddPrize = false
                            }
                            
                        }, label: {
                            
                            Text("Cancel")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 18, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color("primary")))
                                .padding(1)
                            
                        })
                        
                        Button(action: {
                            
                            viewModel.currentGame = viewModel.gName
                            viewModel.prCurGame = viewModel.gName
                            
                            viewModel.prPhoto = viewModel.currentPhoto
                            
                            viewModel.addPrize()
                            
                            viewModel.prName = ""
                            viewModel.prDescription = ""
                            viewModel.currentPhoto = ""
                            
                            viewModel.fetchPrizes()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddPrize = false
                                
                            }
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .padding()
                .offset(y: viewModel.isAddPrize ? 0 : UIScreen.main.bounds.height)
            }
        )
        .onAppear {
            
            viewModel.fetchPrizes()
        }
    }
}

#Preview {
    AddGame(viewModel: GamesViewModel())
}
