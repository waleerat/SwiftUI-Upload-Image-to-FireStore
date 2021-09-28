//
//  CommonIndexView.swift
//  SwiftUI-Upload-Image-to-FireStore
//
//  Created by Waleerat Gottlieb on 2021-09-28.
//

import SwiftUI

import Kingfisher

struct CommonIndexView: View {
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var commonVM = CommonVM()
    
    @State var isShowFormView: Bool = false
    @State var isReload: Bool = false
    @State var groupSelection: CommonModel?
    
    @State var selectionLink:String?
    
    var body: some View {
        // MARK: - Start
        VStack(alignment: .trailing, spacing: 20){
            HStack {
                Text("Sample")
                    .modifier(TextBoldModifier(fontStyle: .header))
                Spacer()
                ButtonWithIconWithClipShapeCircleAction(systemName: "plus", action: {
                    isShowFormView = true
                })
            }
             
            
            // ---
            List{
                // Note: - Row preview
                ForEach(commonVM.contentRows) { row in
                    
                    HStack {
                        if !row.imageURL.isEmpty {
                            KFImage(URL(string: row.imageURL)!)
                                .resizable()
                                .modifier(ThumbnailImageModifier())
                        } else {
                            Image(systemName : "doc.richtext")
                                .resizable()
                                .foregroundColor(.accentColor.opacity(0.6))
                                .modifier(ThumbnailImageModifier())
                        }
                        Text(row.title).modifier(TextBoldModifier(fontStyle: .common))
                        
                        Spacer()
                    }
                   .onTapGesture(perform: {
                        // Note: - Open Sheet to update
                        self.isShowFormView.toggle()
                        commonVM.selectedRow = row
                    })
                    .frame(width: screenSize.width * 0.8)
                  
                }
                .onDelete(perform: delete)
                .listRowBackground(Color(kScreenBackground))
                //: END LOOP CONTENT ROWS
            }
            .listStyle(PlainListStyle())
           // .colorMultiply(Color.clear)
            
            Spacer()
        }
        //:VSTACK
        .onChange(of: isReload, perform: { _ in
            if isReload {
                // Note: - Fetching All data
                commonVM.getRecords()
                commonVM.selectedRow = nil
                // Note: - Close buttom sheet
                isReload = false
            }
        })
        .sheet(isPresented: $isShowFormView, content: {
            if isShowFormView {
                CommonFormView(isReload: $isReload)
                .environmentObject(commonVM)
            }
         })
        .frame(width: screenSize.width * 0.9)
       
        // MARK: - End
    }
    
    // MARK: - HELPER FUNCTIONS
    func delete(at offsets: IndexSet) { 
        commonVM.removeRecord(selectedRow: commonVM.contentRows[offsets.first!]) { (isSuccess) in
            
            commonVM.contentRows.remove(atOffsets: offsets)
        }
        
    }
}
 
 
