protocol Services {
    typealias Repos = ()
    
    var instructor: Instructor { get set }
    var repository: Repos { get set }
}
