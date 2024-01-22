//
//  AskView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/05.
//

import Combine
import Foundation
import MessageUI
import SwiftUI

struct AskView: View {
    @State private var result: Result<MFMailComposeResult, Error>? = nil

    var body: some View {
        if MFMailComposeViewController.canSendMail() {
            EmailSender(result: $result)
                .navigationBarTitle("문의하기")
                .edgesIgnoringSafeArea(.all)
        } else {
            VStack {
                Text("메일 앱이 없습니다")
            }
        }
        
    }
}

struct EmailSender: UIViewControllerRepresentable {
    @Binding var result: Result<MFMailComposeResult, Error>?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        let contents = """
                         -------------------
                         
                         Device Model : \(self.getDeviceIdentifier())
                         Device OS : \(UIDevice.current.systemVersion)
                         App Version : \(self.getCurrentVersion())
                         
                         -------------------
                         
                         아래에 문의하실 내용에 대해 작성해주세요.
                         
                         
                         """
        mail.setSubject("[OPO 문의] \(self.getDeviceIdentifier()) / \(UIDevice.current.systemVersion) / \(self.getCurrentVersion())")
        mail.setToRecipients(["dev.hantae@gmail.com"])
        mail.setMessageBody(contents, isHTML: false)
        
        // delegate 채택
        //    mail.delegate = context.coordinator 주의: 이렇게 하면 안됨!!
        mail.mailComposeDelegate = context.coordinator
        return mail
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    typealias UIViewControllerType = MFMailComposeViewController
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
        @Binding var result: Result<MFMailComposeResult, Error>?

        var parent: EmailSender
        
        init(_ parent: EmailSender, result: Binding<Result<MFMailComposeResult, Error>?>) {
            _result = result
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            if let error = error {
                self.result = .failure(error)
            } else {
                self.result = .success(result)
            }
            
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, result: $result)
    }
    
    // Device Identifier 찾기
    func getDeviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }

    // 현재 버전 가져오기
    func getCurrentVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }
}

struct AskView_Previews: PreviewProvider {
    static var previews: some View {
        AskView()
    }
}
