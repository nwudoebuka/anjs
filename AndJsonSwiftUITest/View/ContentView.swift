//
//  ContentView.swift
//  AndJsonSwiftUITest
//
//  Created by Anthony Nwudo on 03/08/2022.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewModel = MainViewModel()

  @State var city: String = ""
  @State var price: String = ""
  @State var price2: String = ""
    var body: some View {
        NavigationView {
          VStack{
            TextField("Filter by city", text: $city)
                       .padding(20)
                       .frame(height: 40)
            Divider().padding(.horizontal, 10)
            TextField("Filter by prize", text: $price)
                       .padding(20)
                       .frame(height: 40)
            Divider().padding(.horizontal, 10)
            Button(action: {
            // Closure will be called once user taps your button
                    filterCityAndPrice()
                     debugPrint("search items are \(city) and \(price)")
                   }) {
                     Text("Search")
                   }
            List {
              ForEach(viewModel.tableData ?? [Event]()) { item in
                  HStack{
                    VStack(alignment: .leading, spacing: 3){
                      Text("\(item.city)")
                      Text("\(item.name)")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    }
                    Spacer()
                    Text("#\(item.price)")
                  }
                   
                }
            }
        
          }.onAppear(perform: {
            viewModel.getEvents()
          })
          .navigationBarHidden(true)
        }
    }
  
  private func filterCityAndPrice(){
    viewModel.tableData = viewModel.mainData
    guard let tabDataToBeFiltered = viewModel.tableData else{
      return
    }
    if !self.price.isEmpty && !self.city.isEmpty{
        // filter both
      viewModel.tableData = tabDataToBeFiltered.filter {
        $0.city.contains(self.city) && String($0.price).contains(self.price)
        }
    }else if !self.price.isEmpty{
        // filter only price
      viewModel.tableData = tabDataToBeFiltered.filter {
        String($0.price).contains(self.price)
        }
    }else  if !self.city.isEmpty{
        // filter only city
      viewModel.tableData = tabDataToBeFiltered.filter {
        $0.city.contains(self.city)
        }
      }
  }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}



//extension String: Identifiable {
//    public typealias ID = Int
//    public var id: Int {
//        return hash
//    }
//}
