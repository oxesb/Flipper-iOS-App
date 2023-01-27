import SwiftUI

public struct RootView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var viewModel: RootViewModel
    @StateObject var alertController: AlertController = .init()
    @StateObject var hexKeyboardController: HexKeyboardController = .init()

    public init(viewModel: RootViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack {
            if viewModel.isFirstLaunch {
                WelcomeView(viewModel: .init())
            } else {
                MainView(viewModel: .init())
            }

            VStack {
                Spacer()
                HexKeyboard(
                    onButton: { hexKeyboardController.onKey(.hex($0)) },
                    onBack: { hexKeyboardController.onKey(.back) },
                    onOK: { hexKeyboardController.onKey(.ok) }
                )
                .offset(y: hexKeyboardController.isHidden ? 500 : 0)
            }

            if alertController.isPresented {
                alertController.alert
            }
        }
        .customAlert(isPresented: $viewModel.isPairingIssue) {
            PairingIssueAlert(isPresented: $viewModel.isPairingIssue)
        }
        .environmentObject(alertController)
        .environmentObject(hexKeyboardController)
        .onOpenURL { url in
            viewModel.onOpenURL(url)
        }
        .onContinueUserActivity("PlayAlertIntent") { _ in
            viewModel.playAlert()
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .active: viewModel.onActive()
            case .inactive: viewModel.onInactive()
            default: break
            }
        }
    }
}
