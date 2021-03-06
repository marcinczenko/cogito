import Quick
import Nimble
import Foundation
import ReSwiftThunk
@testable import Cogito

class LaunchActionsSpec: QuickSpec {
    override func spec() {
        it("can parse URI fragment") {
            let fragment = "a=b&c=d"
            let parsed = LaunchActions.parse(fragment: fragment)!
            expect(parsed.count) == 2
            expect(parsed["a"]) == "b"
            expect(parsed["c"]) == "d"
        }

        it("cannot parse invalid URI fragments") {
            expect(LaunchActions.parse(fragment: "x")).to(beNil())
        }

        it("dispatches AttestationActions action") {
            let linkString = "https://cogito.mobi/applinks/openid-callback#id_token=whatever&not-before-policy=0"
            // swiftlint:disable:next force_cast
            let startAction = LaunchActions.create(forLink: URL(string: linkString)!)! as! ThunkAction<AppState>
            let dispatchRecorder = DispatchRecorder<OpenIDAttestationActions.FinishRejected>()
            startAction.action(dispatchRecorder.dispatch, { return nil })
            expect(dispatchRecorder.count) == 1
        }
    }
}
