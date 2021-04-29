enum LaunchOption {
    case main
}

final class LaunchInstructor: Instructor {
    var startOption: LaunchOption {
        get {
            return getStartOption()
        }
    }
    
    func getStartOption() -> LaunchOption {
        return .main
    }
}
