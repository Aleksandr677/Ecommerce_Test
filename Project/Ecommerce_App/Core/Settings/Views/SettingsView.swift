//
//  SettingsView.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-12.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    //MARK: - PROPERTIES
    @Binding var selection: TabBarItem
    @AppStorage("isOnboarding") var isRegisterScreen: Bool = true
    
    //choose phote
    @State private var showImagePicker: Bool = false
    @State private var userPicture: UIImage? = nil
    
    //elert message
    @State private var alertErrorMessage: String = ""
    @State private var showAlert: Bool = false
    
    //MARK: - BODY
    var body: some View {
        VStack {
            header
            ScrollView{
                VStack {
                    userPhoto
                    userName
                    uploadItemButton
                    settingsRows
                }
                .padding(.bottom, 130)
            }
        }
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(image: $userPicture)
        })
        .alert("Somethinh went wrong", isPresented: $showAlert, actions: {}) {
            Text("Error\n\(alertErrorMessage)")
        }
    }
}

//MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selection: .constant(.home))
    }
}

//MARK: - EXTENTIONS
//Components
extension SettingsView {
    
    private var header: some View {
        HStack {
            Button(action: {
                withAnimation(.linear) {
                    selection = .home
                }
            },
                   label: {
                Image(systemName: "arrow.left")
                    .padding(.leading, 10)
                    .modifier(FontModifier(fontName: Constants.montserratSemiBold, fontSize: 20))
                    .foregroundColor(.black)
            }) //Button
            Spacer()
            Text("Profile")
                .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 20))
                .offset(x: -15)
            Spacer()
        } //HStack
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private var userPhoto: some View {
        VStack(alignment: .center, spacing: 10) {
            if let userPicture = userPicture {
                Image(uiImage: userPicture)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(30)
                    .frame(width: 60, height: 60)
            } else {
                Image("photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
            }
            
            Button(action: {
                showImagePicker = true
            },
                   label: {
                Text("Change photo")
                    .modifier(FontModifier(fontName: Constants.montserratRegular, fontSize: 12))
            })
        } //VStack
        .padding(.top)
    }
    
    private var userName: some View {
        Text("Satria Adhi Pradana")
            .modifier(FontModifier(fontName: Constants.montserratSemiBold, fontSize: 20))
            .padding(.top, 20)
            .padding(.bottom, 40)
    }
    
    private var uploadItemButton: some View {
        Button(
            action: {
                //do something in here
            },
            label: {
                HStack(alignment: .center, spacing: 40) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("Upload item")
                        .modifier(FontModifier(fontName: Constants.montserratSemiBold, fontSize: 18))
                        .padding(.leading)
                        .offset(x: -20)
                } //HStack
                .frame(height: 46)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(Color.registerTheme.titleColor)
                .background(Color.registerTheme.purple)
                .cornerRadius(18)
                .padding(.horizontal, 40)
            }) //Button
    }
    
    private var settingsRows: some View {
        VStack(spacing: 45) {
            NavigationLink(destination: { TestView() }, label: {
                DefaultSettingsRowView(image: "wallet", title: "Trade store", button: "chevron.right", buttonTitle: nil)
            })
            
            NavigationLink(destination: { TestView() }, label: {
                DefaultSettingsRowView(image: "wallet", title: "Payment method", button: "chevron.right", buttonTitle: nil)
            })
            
            NavigationLink(destination: { TestView() }, label: {
                DefaultSettingsRowView(image: "wallet", title: "Balance", button: nil, buttonTitle: "$1593")
            })
            
            NavigationLink(destination: { TestView() }, label: {
                DefaultSettingsRowView(image: "wallet", title: "Trade history", button: "chevron.right", buttonTitle: nil)
            })
            
            NavigationLink(destination: { TestView() }, label: {
                DefaultSettingsRowView(image: "refresh", title: "Restore Purchase", button: "chevron.right", buttonTitle: nil)
            })
            
            NavigationLink(destination: { TestView() }, label: {
                DefaultSettingsRowView(image: "question", title: "Help", button: nil, buttonTitle: nil)
            })
            
            DefaultSettingsRowView(image: "logOut", title: "Log out", button: nil, buttonTitle: nil)
                .onTapGesture {
                    logOut()
                }
        }
        .padding(.horizontal, 35)
        .padding(.top, 18)
    }
}

//FIREBASE
extension SettingsView {
    private func logOut() {
        do {
            try Auth.auth().signOut()
            isRegisterScreen = true
        } catch let error {
            alertErrorMessage = error.localizedDescription
            showAlert.toggle()
        }
    }
}
