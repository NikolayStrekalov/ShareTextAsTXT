//
//  ContentView.swift
//  ShareTextAsTXT
//
//  Created by User on 13.11.2021.
//

import SwiftUI

/**
 TODO:
 + 1. Как сделать шаринг строки в другое приложение. Как создавать интерфейс шаринга?
 + 2. Шарить файл, заданный в проекте.
 + 3. Добавили текстовый файл и расшарили его текст. Зачем? потому что смогли)
 + 4. Создавать текстовый файл и шарить его.
 5. Создать github-репозиторий и добавить туда текущий проект.
 6. Read:  https://github.com/awseeley/Read-Write-Text-File-Swift-Tutorial/blob/master/ReadWriteText/ViewController.swift
 7. Написать задачи в гитхабе и продолжить разработку с гитхабовским "таск-трекером".
 8. Выложить приложение в App Store.
 */

// From https://stackoverflow.com/questions/35851118/how-do-i-share-files-using-share-sheet-in-ios

/// Get the current directory
///
/// - Returns: the Current directory in NSURL
func getDocumentsDirectory() -> NSString {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory as NSString
}

extension Data {
    
    
    /// Data into file
    ///
    /// - Parameters:
    ///   - fileName: the Name of the file you want to write
    /// - Returns: Returns the URL where the new file is located in NSURL
    func dataToFile(fileName: String) -> NSURL? {
        
        // Make a constant from the data
        let data = self
        
        // Make the file path (with the filename) where the file will be loacated after it is created
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            // Write the file from data into the filepath (if there will be an error, the code jumps to the catch block below)
            try data.write(to: URL(fileURLWithPath: filePath))
            
            // Returns the URL where the new file is located in NSURL
            return NSURL(fileURLWithPath: filePath)
            
        } catch {
            // Prints the localized description of the error from the do block
            print("Error writing the file: \(error.localizedDescription)")
        }
        
        // Returns nil if there was an error in the do-catch -block
        return nil
        
    }
}

struct ContentView: View {
    
    @State private var longText: String = "This is some editable text..."
    // FIXME: зачем эта переменная?
    //    @State private var isShareSheetShowing = false
    let image = UIImage(named: "qqq")
    func shareText() {
        //        isShareSheetShowing.toggle()
        print(longText)
        
//        do {
//            let path = Bundle.main.path(forResource: "README", ofType: "txt")
////            let text = try String(contentsOfFile: path!, encoding: .utf8)
//            let file = FileHandle.init(forReadingAtPath: path!)
//
//            let activityView = UIActivityViewController(activityItems: [file], applicationActivities: nil)
//
//            UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
//        } catch let error {
//            // Handle error here
//            print(error)
//        }
        

        // Convert the String into Data
        let textData = longText.data(using: .utf8)

        // Write the text into a filepath and return the filepath in NSURL
        // Specify the file type you want the file be by changing the end of the filename (.txt, .json, .pdf...)
        let textURL = textData?.dataToFile(fileName: "nameOfYourFile.txt")

        let activityView = UIActivityViewController(activityItems: [textURL], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
    
    var body: some View {
        VStack{
            TextEditor(
                text: $longText
            )
                .disableAutocorrection(true)
                .border(.secondary)
                .padding(.all, 10)
            
            
            Button(action: shareText) {
                HStack {
                    
                    Text("Share It")
                    Image(systemName: "square.and.arrow.up")
                    
                }
            }
            .buttonStyle(.bordered)
            //.frame(maxWidth: .infinity)  // TODO: сделать кнопочку в ширину экрана
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
