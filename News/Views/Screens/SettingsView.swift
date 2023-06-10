//
//  SettingsView.swift
//  News
//
//  Created by Oleksii Leshchenko on 08.06.2023.
//


import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isDark") var isDark: Bool = false
    @AppStorage("theme") var appTheme: Themes = .main
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    GroupBox(label: SettingsLabelView(labelText: "News (Beta)", labelImage: "info.circle")) {
                        Divider().padding(.vertical, 4)
                        
                        HStack(alignment: .center, spacing: 10) {
                            Image("placeholder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(9)
                            
                            Text("This application is made using [News API](https://newsapi.org) for educational purposes. May contain numerous bugs and behave unpredictably")
                                .font(.footnote)
                                .foregroundColor(appTheme.fontPrimary)
                        }
                    }
                    
                    GroupBox(label: SettingsLabelView(labelText: "customization", labelImage: "paintbrush")) {
                        Divider().padding(.vertical, 4)
                        
           
                            Toggle(isOn: $isDark) {
                              
                                if isDark {
                                    Text("Dark".uppercased())
                                        .fontWeight(.bold)
                                        .foregroundColor(appTheme.fontSecondary)
                                } else {
                                    Text("Light".uppercased())
                                        .fontWeight(.bold)
                                    .foregroundColor(appTheme.fontSecondary)                            }
                            }
                            
                            Divider()
                            
                        HStack {
                            Text("Theme".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(appTheme.fontSecondary)
                            
                            Spacer()
                            
                            Picker(
                                    selection: $appTheme,
                                    label: Text("Theme".uppercased()),
                                    content: {
                                        ForEach(Themes.allCases, id: \.self) { option in
                                            HStack {
                                                Text(option.rawValue.capitalized)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(appTheme.fontSecondary)
                                                    .tag(option.rawValue)
                                            }
                                        }
                                        
                                    }).pickerStyle(.segmented)
                            
                       
                        }
                    }
                    .background(
                        appTheme.backgroundSecondary
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    )
                    
                    GroupBox(label: SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")) {
                        SettingsRowView(name: "Developer", content: "Oleksii Leshchenko")
                        SettingsRowView(name: "Designer", content: "Oleksii Leshchenko")
                        SettingsRowView(name: "Compatibility", content: "iOS 16")
                        SettingsRowView(name: "Twitter", linkLabel: "@O_V_Leshchenko", linkDestination: "twitter.com/O_V_Leshchenko")
                        SettingsRowView(name: "Version", content: "0.5.0")
                    }
                }
            }
            .padding()
        }
        .navigationViewStyle(.stack)
        .tint(appTheme.tintColor)
        .tabItem {
            Image(systemName: "gearshape")
            Text("Settings")
                .multilineTextAlignment(.center)
        }
    }
}

struct SettingsRowView: View {
    let name: String
    var content: String? = nil
    var linkLabel: String? = nil
    var linkDestination: String? = nil
    @AppStorage("theme") var appTheme: Themes = .main
    
    var body: some View {
        VStack {
            Divider().padding(4)
            
            HStack {
                Text(name)
                    .foregroundColor(appTheme.fontSecondary)
                
                Spacer()
                
                if content != nil {
                    Text(content!)
                        .foregroundColor(appTheme.fontPrimary)
                } else if linkLabel != nil && linkDestination != nil {
                    Link(destination: URL(string:"https://\(linkDestination!)")!) {
                        Text(linkLabel!)
                        Image(systemName: "arrow.up.right.square").foregroundColor(appTheme.fontSecondary)
                    }
                } else {
                    EmptyView()
                }
            }
        }
    }
}

struct SettingsLabelView: View {
    let labelText: String
    let labelImage: String
    @AppStorage("theme") var appTheme: Themes = .main
    
    var body: some View {
        HStack {
            Text(labelText.uppercased())
                .fontWeight(.bold)
                .foregroundColor(appTheme.fontPrimary)
            
            Spacer()
            
            Image(systemName: labelImage)
                .foregroundColor(appTheme.fontPrimary)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
