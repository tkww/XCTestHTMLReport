//
//  TesstGroupCollection.swift
//  XCTestHTMLReport
//
//  Created by Evan Coleman on 9/1/20.
//

import Foundation
import XCResultKit

struct TestGroupCollection: HTML {

    let uuid: String
    let name: String
    let identifier: String
    let duration: Double
    let testGroups: [TestGroup]

    var allSubTests: [Test] {
        return testGroups.flatMap { $0.allSubTests }
    }

    init(name: String, testGroups: [TestGroup]) {
        self.uuid = "GROUP-\(UUID().uuidString)"
        self.identifier = name
        self.duration = testGroups.reduce(0) { $0 + $1.duration }
        self.name = name
        // Fixes the duplicate tests showing up in the Joined runs summary.
        // For further context please check the following task: https://theknotww.atlassian.net/browse/PM-68
        self.testGroups = testGroups.filter { $0.name != name }
    }

    // PRAGMA MARK: - HTML

    var htmlTemplate = HTMLTemplates.testGroupCollection

    var htmlPlaceholderValues: [String: String] {
        return [
            "UUID": uuid,
            "NAME": name + (testGroups.count > 0 ? " - \(testGroups.count) tests" : ""),
            "TIME": duration.timeString,
            "TEST_GROUPS": testGroups.accumulateHTMLAsString,
        ]
    }
}
