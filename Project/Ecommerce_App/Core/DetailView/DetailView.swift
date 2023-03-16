//
//  DetailView.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-15.
//

import SwiftUI

struct DetailView: View {
    //MARK: - PROPERTIES
    let details: Details
    @State private var image: Image = Image("")
    @State private var rotationAngle = 0.0
    @State private var isRotating: Bool = true
    @State private var quantity: Int = 1
    @State private var price: Double = 0.0
    @State private var color: Color = Color.clear
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var homeVM: HomeViewModel
    
    //MARK: - BODY
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                mainImage
                pickerImages
                VStack(alignment: .leading, spacing: 15) {
                    titleAndPrice
                    description
                    rating
                    colors
                }
                .padding(.horizontal, 25)
                .padding(.top, 30)
                .padding(.bottom, 140)
            }//VStack
            .padding(.top, 80)
        } //Scroll
        .navigationBarBackButtonHidden()
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top)
        .overlay(alignment: .topLeading) {
            Button(action: {
                self.dismiss.callAsFunction()
            },
                   label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.black)
                    .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 20))
                    .padding(.leading)
            })
        }
        .overlay(alignment: .bottom) {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text("Quantity:  \(quantity)")
                            .foregroundColor(Color.generalTheme.accent)
                            .modifier(FontModifier(fontName: Constants.montserratSemiBold, fontSize: 15))
                        Spacer()
                    }
                    HStack {
                        minusButton
                        plusButton
                    }
                }
                Button(action: {
                    homeVM.addItemToBuy(price: self.price, name: details.name, image: self.image, color: self.color)
                    self.color = Color.clear
                    self.quantity = 1
                    self.price = 0.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        dismiss.callAsFunction()
                    }
                },
                       label: {
                    HStack(spacing: 20) {
                        Text(quantity == 1 ? "\(details.price.asCurrencyWith2Decimals())" :
                                "\(price.asCurrencyWith2Decimals())")
                            .foregroundColor(Color.white)
                            .modifier(FontModifier(fontName: Constants.montserratSemiBold, fontSize: 15))
                        Text("ADD TO CART")
                            .foregroundColor(Color.white)
                            .modifier(FontModifier(fontName: Constants.montserratSemiBold, fontSize: 12))
                    }
                    .frame(width: 170, height: 40)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.registerTheme.purple)
                    )
                })
            }
            .padding(.horizontal, 25)
            .padding(.top, 15)
            .padding(.bottom, 50)
            .background(
                Color.generalTheme.deepBlack
            )
            .cornerRadius(35)
        }
        .background(Color.generalTheme.pageBackground.ignoresSafeArea())
        .edgesIgnoringSafeArea(.bottom)
    }
}

//MARK: - PREVIEW
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(details: Details(
            name: "Reebok Classic",
            description: "Shoes inspired by 80s running shoes are still relevant today",
            rating: 4.3,
            numberOfReviews: 4000,
            price: 24,
            colors: ["#ffffff", "#b5b5b5", "#000000"],
            imageURL: ["https://assets.reebok.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/3613ebaf6ed24a609818ac63000250a3_9366/Classic_Leather_Shoes_-_Toddler_White_FZ2093_01_standard.jpg",
                       "https://assets.reebok.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/a94fbe7d8dfb4d3bbaf9ac63000135ed_9366/Classic_Leather_Shoes_-_Toddler_White_FZ2093_03_standard.jpg",
                       "https://assets.reebok.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/1fd1b80693d34f2584b0ac6300034598_9366/Classic_Leather_Shoes_-_Toddler_White_FZ2093_05_standard.jpg"
                      ])
        )
    }
}

//MARK: - EXTENTIONS
extension DetailView {
    private var mainImage: some View {
        DetailImageView(image: $image)
            .rotation3DEffect(Angle(degrees: rotationAngle), axis: (x: 1, y: 0, z: 1))
            .rotation3DEffect(Angle(degrees: rotationAngle), axis: (x: 0, y: 0, z: 1))
            .scaleEffect(isRotating ? 1.0 : 0.1)
            .overlay(alignment: .bottomTrailing) {
                VStack(spacing: 15) {
                    Button(action: {
                        //do something here
                    },
                           label: {
                        Image("heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 17)
                    })
                    RoundedRectangle(cornerRadius: 1)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                    Button(action: {
                        //do something here
                    },
                           label: {
                        Image("link")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 17)
                    })
                }
                .frame(width: 45, height: 95)
                .background(Color.generalTheme.pageBackground)
                .cornerRadius(15)
                .padding(.trailing, 8)
            }
    }
    
    private var pickerImages: some View {
        HStack(spacing: 10) {
            ForEach(details.imageURL, id: \.self) { url in
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 65, height: 40)
                        .cornerRadius(8)
                        .padding(4)
                        .scaleEffect(
                            withAnimation(.easeInOut) {
                                image == self.image ? 1.2 : 1.0
                            }
                        )
                        .shadow(
                            color: Color.black.opacity(0.15),
                            radius: image == self.image ? 5 : 0,
                            y: image == self.image ? 4 : 0)
                        .onAppear(perform: {
                            self.image = image
                        })
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.75)) {
                                self.isRotating = false
                                self.rotationAngle += 360
                                self.image = image
                                self.isRotating = true
                            }
                        }
                } placeholder: {
                    EmptyView()
                }
            } //Loop
        } //HStack
        .frame(height: 40)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 70)
    }
    
    private var titleAndPrice: some View {
        HStack(alignment: .top) {
            Text(details.name)
                .foregroundColor(Color.black)
                .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 17))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            Spacer()
            Text(details.price.asCurrencyWith2Decimals())
                .foregroundColor(Color.black)
                .modifier(FontModifier(fontName: Constants.montserratSemiBold, fontSize: 15))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
    }
    
    private var description: some View {
        Text(details.description)
            .foregroundColor(Color.generalTheme.accent)
            .modifier(FontModifier(fontName: Constants.montserratRegular, fontSize: 11))
            .frame(width: 200, height: 35, alignment: .leading)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
    }
    
    private var rating: some View {
        HStack(alignment: .center, spacing: 7) {
            Image("star")
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14)
            
            Text("\(details.rating.asReviewWith2Decimals())")
                .foregroundColor(Color.black)
                .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 12))
            
            Text("( \(details.numberOfReviews) reviews )")
                .foregroundColor(Color.generalTheme.accent)
                .modifier(FontModifier(fontName: Constants.montserratRegular, fontSize: 14))
        }
    }
    
    private var colors: some View {
        VStack(alignment: .leading) {
            Text("Color:")
                .foregroundColor(Color.generalTheme.accent)
                .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 15))
            HStack(spacing: 15) {
                ForEach(details.colors, id: \.self) { color in
                    RoundedRectangle(cornerRadius: 7)
                        .fill(Color(hex: color))
                        .frame(width: 32, height: 24)
                        .padding(3)
                        .background(Color.generalTheme.accent.opacity(0.3))
                        .cornerRadius(8)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                self.color = Color(hex: color)
                            }
                        }
                        .scaleEffect(self.color == Color(hex: color) ? 1.3 : 1.0)
                }
            }
        }
    }
    
    private var minusButton: some View {
        Button(action: {
            if quantity >= 2 {
                quantity -= 1
                updatePrice()
            }
        }, label: {
            Image(systemName: "minus")
                .frame(width: 39, height: 22, alignment: .center)
                .padding(3)
                .foregroundColor(Color.white)
                .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 12))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.registerTheme.purple)
                )
        })
    }
    
    private var plusButton: some View {
        Button(action: {
            if quantity >= 1 {
                quantity += 1
                updatePrice()
            }
        }, label: {
            Image(systemName: "plus")
                .frame(width: 39, height: 22, alignment: .center)
                .padding(3)
                .foregroundColor(Color.white)
                .modifier(FontModifier(fontName: Constants.montserratBold, fontSize: 12))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.registerTheme.purple)
                )
        })
    }
}

extension DetailView {
    private func updatePrice () {
        self.price = Double(Double(quantity) * details.price)
    }
}
