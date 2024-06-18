//
//  PrizesView.swift
//  App564
//
//  Created by DJUROM on 03/06/2024.
//

import SwiftUI

struct PrizesView: View {
    
    @StateObject var viewModel = PrizesViewModel()
    
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAddPrize = true
                    }
                    
                }, label: {
                    
                   Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text("List a prizes")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if viewModel.prizes.isEmpty {
                    
                    VStack {
                        
                        Text("Add your first prize")
                            .foregroundColor(.black)
                            .font(.system(size: 26, weight: .bold))
                        
                        Image("prizess")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddPrize = true
                            }
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                                .padding()
                        })
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    
                    Spacer()
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack(spacing: 12) {
                            
                            ForEach(viewModel.prizes, id: \.self) { index in
                                
                                VStack(spacing: 14) {
                                    
                                    Image(index.prPhoto ?? "")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 220)
                                    
                                    Text(index.prName ?? "")
                                        .foregroundColor(.black)
                                    .font(.system(size: 20, weight: .medium))
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                    Text(index.prDescription ?? "")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 15, weight: .regular))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 350)
                                .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                            }
                        }
                    }
                }

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
                            
                            viewModel.prPhoto = viewModel.currentPhoto
                            
                            viewModel.addPrize()
                            
                            viewModel.currentPhoto = ""
                            viewModel.prName = ""
                            viewModel.prDescription = ""
                            
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
                        .opacity(viewModel.currentPhoto.isEmpty || viewModel.prName.isEmpty || viewModel.prDescription.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.currentPhoto.isEmpty || viewModel.prName.isEmpty || viewModel.prDescription.isEmpty ? true : false)
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
    PrizesView()
}
