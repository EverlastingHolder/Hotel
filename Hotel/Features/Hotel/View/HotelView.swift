import SwiftUI

struct HotelView: View {
    @Bindable var viewModel: HotelViewModel = .init()
    
    private let specialtyAction: [SpecialtyAction] = [
        .init(icon: "happy", title: "Удобства", description: "Самое необходимое"),
        .init(icon: "checkmarkBox", title: "Что включено", description: "Самое необходимое"),
        .init(icon: "close", title: "Что не включено", description: "Самое необходимое")
    ]
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
    }
    
    var body: some View {
        NavigationStack {
            APIResultView(result: $viewModel.hotel) { item in
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack{
                                if !item.imageUrls.isEmpty {
                                    TabView {
                                        ForEach(item.imageUrls, id: \.self) { item in
                                            AsyncImage(url: URL(string: item)) { result in
                                                if let image = result.image {
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .clipShape(.rect(cornerRadius: 15))
                                                } else if result.error != nil {
                                                    Text("Error")
                                                } else {
                                                    ProgressView()
                                                }
                                            }
                                        }
                                    }
                                    .frame(height: 200)
                                    .clipShape(.rect(cornerRadius: 15))
                                    .tabViewStyle(.page(indexDisplayMode: .always))
                                }
                            }
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Label {
                                        Text("\(item.rating) \(item.ratingName)")
                                            .bold()
                                    } icon: {
                                        Image(systemName: "star.fill")
                                    }
                                    .foregroundStyle(Color("StarColor"))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(Color("BackgroundStarColor"))
                                    .clipShape(.rect(cornerRadius: 5))
                                }
                                
                                Text(item.name)
                                    .font(.system(size: 22, weight: .medium))
                                
                                Text(item.adress)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(Color("TagColor"))
                            }
                            
                            HStack {
                                Text("от \(item.minimalPrice) ₽")
                                    .font(.system(size: 30, weight: .semibold))
                                Text(item.priceForIt.lowercased())
                                    .font(.system(size: 16))
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical, 16)
                        }
                        .backgroundCapsule()
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Об отеле")
                                .padding(.top, 16)
                                .font(.system(size: 22, weight: .medium))
                            
                            FlexibleView(data: item.aboutHotel.peculiarities, spacing: 4, alignment: .leading) { tag in
                                Text(tag)
                                    .foregroundStyle(Color(hex: "828796"))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color(hex: "FBFBFC"))
                                    .clipShape(.rect(cornerRadius: 5))
                            }
                            
                            Text(item.aboutHotel.description)
                                .font(.system(size: 16))
                                .opacity(0.9)
                                .padding(.top, 12)
                            
                            VStack {
                                ForEach(specialtyAction, id: \.id) { action in
                                    VStack(spacing: 0) {
                                        HStack(spacing: 12) {
                                            Image(action.icon)
                                            
                                            VStack(alignment: .leading, spacing: 2) {
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 0) {
                                                        Text(action.title)
                                                        Text(action.description)
                                                    }
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: "chevron.right")
                                                }
                                                .overlay(alignment: .bottom) {
                                                    if specialtyAction.last != action {
                                                        Divider()
                                                            .offset(y: 10)
                                                    }
                                                }
                                            }
                                            
                                        }
                                        .padding(.horizontal, 15)
                                        .padding(.bottom, specialtyAction.last == action ? 0 : 10)
                                    }
                                }
                            }
                            .padding(.vertical, 15)
                            .background(Color(hex: "FBFBFC"))
                            .clipShape(.rect(cornerRadius: 15))
                            .padding(.bottom, 16)
                        }
                        .backgroundCapsule()
                        .padding(.bottom, 12)
                    }
                    .background(Color("BackgroundAppColor"))
                    
                    Divider()
                        .padding(.bottom)
                    
                    NavigationLink(destination: Text("Hotel")) {
                        HStack {
                            Spacer()
                            Text("К выбору номера")
                                .foregroundStyle(.white)
                                .font(.system(size: 16, weight: .medium))
                            Spacer()
                        }
                    }
                    .padding(.vertical, 16)
                    .background(Color.blue)
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(.horizontal)
                }
            }
            .navigationTitle(Text("Отель"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HotelView()
}
