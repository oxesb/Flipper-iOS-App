import Core
import SwiftUI

struct OptionsView: View {
    @StateObject var viewModel: OptionsViewModel

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Utils")) {
                    NavigationLink("Protobuf ping") {
                        PingView(viewModel: .init())
                    }
                    NavigationLink("RPC Stress Test") {
                        StressTestView(viewModel: .init())
                    }
                    NavigationLink("RPC Speed Test") {
                        RPCSpeedTestView(viewModel: .init())
                    }
                }

                Section(header: Text("Archive")) {
                    NavigationLink("Deleted Items") {
                        ArchiveBinView(viewModel: .init())
                    }
                }

                Section(header: Text("Demo")) {
                    Button("Reboot Flipper") {
                        Task {
                            try await RPC.shared.reboot(to: .os)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}