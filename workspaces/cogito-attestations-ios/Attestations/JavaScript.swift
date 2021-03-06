import JavaScriptCore
import Security

class Javascript {
    static let context = JSContext()!
        .setExceptionHandler(onException)
        .addConsole()
        .addCrypto()
        .addAttestations()
}

extension JSContext {
    func load(filename: String) -> JSContext {
        let bundle = Bundle(for: Javascript.self)
        let path = bundle.path(forResource: filename, ofType: "js")!
        let script = try! String(contentsOfFile: path)
        evaluateScript(script)
        return self
    }

    fileprivate func setExceptionHandler(_ handler: @escaping (JSContext?, JSValue?) -> Void) -> JSContext {
        exceptionHandler = handler
        return self
    }
}

private func onException(context: JSContext?, value: JSValue?) {
    let message = value?.toString() ?? "unknown error"
    assertionFailure("JavaScript error: \(message)")
}
