//
//  ContentView.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-10.
//

import SwiftUI

struct HomeView: View {
    //MARK: - PROPERTIES
    @State private var showSheet: Bool = false
    @EnvironmentObject private var homeVM: HomeViewModel
    
    //MARK: - BODY
    var body: some View {
        VStack {
            header
            Spacer()
            ScrollView {
                DefaultTextField(placeholder: "What are you looking for?", textFieldInput: $homeVM.searchText, showIcon: true)
                    .padding(.horizontal, 55)
                    .padding(.top, 12)
                SelectCategoryGrid()
                VStack {
                    ViewAllRow(title: "Latest")
                        .padding(.top, 35)
                        .padding(.bottom, 1)
                    latestRow
                    flashSaleViewAll
                    flashSaleRow
                } //VStack
                .padding(.horizontal, 11)
                .padding(.bottom, 130)
            } //Scroll
        } //VStack
        .onTapGesture {
            self.endTextEditing()
        }
        .background(Color.generalTheme.pageBackground)
        .sheet(isPresented: $showSheet) {
            TestView()
        }
    }
}

//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static let homeViewModel = HomeViewModel()
    static var previews: some View {
        NavigationView {
            HomeView()
        }
        .environmentObject(homeViewModel)
    }
}

//MARK: - EXTENTIONS
//Components
extension HomeView {
    private var header: some View {
        HStack {
            Button(action: {
                showSheet.toggle()
            },
                   label: {
                Image("lines")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 24)
            }) //Button
            Spacer()
            HStack(alignment: .center, spacing: 7) {
                Text("Trade by")
                    .foregroundColor(Color.black)
                    .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 20))
                
                Text("bata")
                    .foregroundColor(Color.registerTheme.purple)
                    .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 20))
            } //HStack
            .offset(x: 18)
            Spacer()
            VStack {
                Image("photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .background(
                        Circle()
                        .fill(Color.blue)
                        .frame(width: 32, height: 32)
                    )
                NavigationLink(destination: {
                    TestView()
                },
                               label: {
                    HStack(alignment: .center, spacing: 5) {
                        Text("Location")
                            .foregroundColor(Color.generalTheme.accent)
                            .modifier(FontModifier(fontName: Constants.montserratRegular, fontSize: 10))
                        Image(systemName: "chevron.down")
                            .resizable()
                            .frame(width: 8, height: 5)
                    } //HStack
                }) //Navigation
            } //VStack
        }//HStack
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.leading, 15)
        .padding(.trailing, 37)
    }
    
    private var latestRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(homeVM.allLatest, id: \.self) { latestItem in
                    LatestItem(latestItem: latestItem, isLoaded: $homeVM.isLoading)
                }
            }
            .frame(height: 150)
        }
    }
    
    private var flashSaleRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(homeVM.allFlashSale, id: \.self) { flashSaleItem in
                    NavigationLink(destination: {
                        if let details = homeVM.details {
                            DetailView(details: details)
                        }
                    },
                                   label: {
                        FlashSaleItem(flashSaleItem: flashSaleItem, isLoaded: $homeVM.isLoading)
                    })
                }
            }
            .frame(height: 230)
        }
    }
    
    private var flashSaleViewAll: some View {
        NavigationLink(destination: {
            if let details = homeVM.details {
                DetailView(details: details)
            }
        },
                       label: {
            ViewAllRow(title: "Flash Sale")
                .padding(.top, 22)
                .padding(.bottom, 3)
        })
    }
}
