import Foundation
import Logging

public class UserDefaultsStorage {
    public static let shared: UserDefaultsStorage = .init()
    private var storage: UserDefaults { .standard }

    public var isFirstLaunch: Bool {
        get { storage.value(forKey: .isFirstLaunchKey) as? Bool ?? true }
        set { storage.set(newValue, forKey: .isFirstLaunchKey) }
    }

    public var selectedTab: String {
        get { storage.value(forKey: .selectedTabKey) as? String ?? "" }
        set { storage.set(newValue, forKey: .selectedTabKey) }
    }

    public var updateChannel: String {
        get { storage.value(forKey: .updateChannelKey) as? String ?? "" }
        set { storage.set(newValue, forKey: .updateChannelKey) }
    }

    public var logLevel: Logger.Level {
        get {
            if let level = storage.value(forKey: .logLevelKey) as? String {
                return .init(rawValue: level) ?? .debug
            } else {
                return .debug
            }
        }
        set {
            storage.set(newValue.rawValue, forKey: .logLevelKey)
        }
    }

    public var isDebugMode: Bool {
        get { storage.value(forKey: .isDebugMode) as? Bool ?? true }
        set { storage.set(newValue, forKey: .isDebugMode) }
    }

    public var isProvisioningDisabled: Bool {
        get { storage.value(forKey: .isDebugMode) as? Bool ?? true }
        set { storage.set(newValue, forKey: .isDebugMode) }
    }

    func reset() {
        storage.removeObject(forKey: .isFirstLaunchKey)
        storage.removeObject(forKey: .selectedTabKey)
        storage.removeObject(forKey: .updateChannelKey)
        storage.removeObject(forKey: .logLevelKey)
        storage.removeObject(forKey: .isDebugMode)
        storage.removeObject(forKey: .isProvisioningDisabled)
    }
}

public extension String {
    static var isFirstLaunchKey: String { "isFirstLaunch" }
    static var selectedTabKey: String { "selectedTab" }
    static var updateChannelKey: String { "updateChannel" }
    static var logLevelKey: String { "logLevel" }

    static var isDebugMode: String { "isDebugMode" }
    static var isProvisioningDisabled: String { "isProvisioningDisabled" }
}
