import SwiftUI

struct AddProductScreen: View {
    @State private var title: String = ""
    @State private var price: Double?
    @State private var description: String = ""
    @Environment(\.dismiss) private var dismiss
    @Environment(PlatziStore.self) private var store
    
    @State private var selectedCategoryId: Int
    let onSave: (Product) -> Void
    
    init( selectedCategoryId: Int,  onSave: @escaping (Product) -> Void) {
        self.selectedCategoryId = selectedCategoryId
        self.onSave = onSave
    }
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace && !description.isEmptyOrWhitespace && price != nil && price! > 0
    }
    
    private func saveProduct() async {
        guard let price = price else {
            return
        }
        
        do {
            let newProduct = try await store.createProduct(
                title: title,
                price: price,
                description: description,
                categoryId: selectedCategoryId,
                images: [URL.randomImageURL]
            )
            
            onSave(newProduct)
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    var body: some View {
        Form {
            Picker("Select a category", selection: $selectedCategoryId) {
                ForEach(store.categories) { category in
                    Text(category.name)
                        .tag(category.id)
                }
            }.pickerStyle(.automatic)
            
            TextField("Title", text: $title)
            TextField("Price", value: $price, format: .number)
                .keyboardType(.decimalPad)
            TextEditor(text: $description)
                .frame(height: 100)
            
        }.task {
            do{
                try await store.loadCategories()
            } catch {
                print(error.localizedDescription)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading ) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem( placement: .topBarTrailing){
                Button("Save Product") {
                    Task { await saveProduct() }
                }.disabled(!isFormValid)
            }
        }
    }
}

#Preview {
    NavigationStack{
        AddProductScreen(selectedCategoryId: 1,onSave: {_ in})
    }.environment(PlatziStore(httpClient: HTTPClient()))
}
