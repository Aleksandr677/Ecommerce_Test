//
//  RegisterScreen.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-10.
//

import SwiftUI
import FirebaseAuth

struct RegisterScreen: View {
    //MARK: - PROPERTIES
    @State private var isSignInPage: Bool = true
    @State private var rotationAngle = 0.0
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    //user's input data
    @State private var userFirstName: String = ""
    @State private var userLastName: String = ""
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    
    //elert message
    @State private var alertErrorMessage: String = ""
    @State private var showAlert: Bool = false
    
    //MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            background
            ScrollView {
                VStack(alignment: .center) {
                    title
                    textfieldsRow
                    registerButton
                    if isSignInPage {
                        signInOptions
                    }
                } //VStack
                .rotation3DEffect(Angle(degrees: rotationAngle), axis: (x: 0, y: 1, z: 0))
                .padding(.top, 80)
                .padding(.horizontal, 43)
                .rotation3DEffect(Angle(degrees: rotationAngle), axis: (x: 0, y: 1, z: 0))
            } //VStack
        } //Scroll
        .alert("Something went wrong...", isPresented: $showAlert, actions: {}, message: {
            Text(alertErrorMessage)
        })
        .onTapGesture {
            self.endTextEditing()
        }
        .onAppear {
            //check if user has already created a profile
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    isOnboarding = false
                }
            }
        }
    }//ZStack
}

//MARK: - PREVIEW
struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}

//MARK: - EXTENTIONS
//Components
extension RegisterScreen {
    private var background: some View {
        Color.generalTheme.pageBackground.ignoresSafeArea()
    }
    
    private var title: some View {
        Text(isSignInPage ? "Sign in" : "Welcome back")
            .modifier(FontModifier(fontName: Constants.montserratSemiBold, fontSize: 25))
            .foregroundColor(.black)
            .shadow(color: Color.black.opacity(0.4), radius: 2, y: 5)
    }
    
    private var textfieldsRow: some View {
        VStack(spacing: 35) {
            if isSignInPage {
                DefaultTextField(placeholder: "First name", textFieldInput: $userFirstName)
                DefaultTextField(placeholder: "Last name", textFieldInput: $userLastName)
                DefaultTextField(placeholder: "Email", textFieldInput: $userEmail)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                PasswordTextfield(text: $userPassword, placeholder: "Password")
            } else {
                DefaultTextField(placeholder: "Email", textFieldInput: $userEmail)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                PasswordTextfield(text: $userPassword, placeholder: "Password")
            }
        }
        .padding(.top, 80)
        .padding(.bottom, isSignInPage ? 35 : 80)
    }
    
    private var registerButton: some View {
        VStack(alignment: .leading,spacing: 18) {
            Button(
                action: {
                    textFieldValidatorEmail()
                },
                label: {
                    Text(isSignInPage ? "Sign in" : "Login")
                        .frame(height: 46)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color.registerTheme.titleColor)
                        .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 15))
                        .background(content: {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 2.5)
                        })
                        .background(Color.registerTheme.purple)
                        .cornerRadius(15)
                }) //Button
            .allowsHitTesting(isEnabled() ? true : false)
            .opacity(isEnabled() ? 1.0 : 0.6)
            .shadow(color: Color.black.opacity(0.2), radius: 3, y: 7)
            
            if isSignInPage {
                haveAccont
            } else {
                Text("Back to sign in page")
                    .modifier(FontModifier(fontName: Constants.montserratRegular, fontSize: 13))
                    .foregroundColor(Color.generalTheme.accent)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.7)) {
                            isSignInPage = true
                            rotationAngle += 180
                        }
                    }
            }
        } //VStack
        .padding(.bottom, 75)
    }
    
    private var haveAccont: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.7)) {
                isSignInPage = false
                rotationAngle += 180
            }
        }, label: {
            HStack(alignment: .center) {
                Text("Already have an account?")
                    .modifier(FontModifier(fontName: Constants.montserratRegular, fontSize: 13))
                    .foregroundColor(Color.generalTheme.accent)
                
                Text("Log in")
                    .modifier(FontModifier(fontName: Constants.montserratSemiBold, fontSize: 14))
                    .foregroundColor(Color.registerTheme.purple)
            } //HStack
        })
    }
    
    private var signInOptions: some View {
        VStack(alignment: .leading, spacing: 40) {
            SignInOptionRow(imageName: "googleIcon", title: "Sign in with Google")
            SignInOptionRow(imageName: "appleIcon", title: "Sign in with Apple")
        }
        .padding(.bottom, 30)
    }
}

//Functions
extension RegisterScreen {
    //validate email
    private func textFieldValidatorEmail() {
        guard userEmail.count < 100 && !userEmail.isEmpty else { return }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        if !emailPredicate.evaluate(with: userEmail) {
            alertErrorMessage = "Error using your email.\nYour email is NOT valid.\nA valid email should look like this one:\n jack-hofman10@mail.ru"
            showAlert.toggle()
        } else {
            withAnimation(.easeInOut(duration: 0.7)) {
                isSignInPage ? signUp() : logIn()
                userFirstName = ""
                userLastName = ""
                userEmail = ""
                userPassword = ""
            }
        }
    }
    
    //make sure that all necessary data is provided
    private func isEnabled() -> Bool {
        if userEmail.isEmpty || userPassword.isEmpty || userPassword.count < 6 {
            return false
        } else {
            return true
        }
    }
    
    //Firebase sign up
    private func signUp() {
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { result, error in
            guard error == nil else {
                alertErrorMessage = "This account has already been signed in.\nYou will be transfered to login page."
                showAlert.toggle()
                isSignInPage = false
                return
            }
        }
    }
    
    //Firebase login
    private func logIn() {
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { result, error in
            guard error == nil else {
                alertErrorMessage = "There is no any accounts with these email and password.\nPlease check the info you provided."
                showAlert.toggle()
                return
            }
            isOnboarding = false
        }
    }
}

