//
//  TestScreenshotFlow.swift
//  XCTestHTMLReport
//

import Foundation

struct TestAttachmentList
{
    var attachments: [AttachmentListAttachment]
    var padding: Int

    init?(activities: [Activity]?, padding: Int) {
        guard let activities = activities else {
            return nil
        }

        self.padding = padding

        let anyAttachments = activities.trueForAny { !$0.allAttachments.filter { !$0.isScreenshot }.isEmpty }
        guard anyAttachments else {
            return nil
        }
        attachments = activities
            .flatMap { activity in
                return activity.allAttachments
                    .filter { !$0.isScreenshot }
                    .map { AttachmentListAttachment(attachment: $0, className: "attachment-item", padding: padding + 8) }
            }
    }

}

fileprivate extension Sequence {
    // Determines whether any element in the Array matches the conditions defined by the specified predicate.
    func trueForAny(_ predicate: (Element) -> Bool) -> Bool {
        return first(where: predicate) != nil
    }
}

struct AttachmentListAttachment: HTML {
    let attachment: Attachment
    let className: String
    let padding: Int

    var htmlTemplate: String {
        return """
        <p class=\"list-item\">
        <span style=\"margin-left: [[PADDING]]px\" class=\"padding\"></span>
        <span class=\"icon left drop-down-icon\" onclick=\"toggleAttachment(this, '[[FILENAME]]')\"></span>
        [[DISPLAY_NAME]]
        <span class=\"icon paperclip-icon\" style=\"display: inline-block\"></span>
        </p>
        <div id=\"attachment-[[FILENAME]]\" class=\"\(className)\">
            [[CONTENT]]
        </div>
        """
    }

    var htmlPlaceholderValues: [String: String] {
        let content: String? = { content in
            switch content {
            case .data(let data):
                return String(data: data, encoding: .utf8)
            case .url(let url):
                return try? String(contentsOf: url)
            case .none:
                return nil
            }
        }(attachment.content)

        return [
            "SRC": attachment.source ?? "",
            "FILENAME": attachment.filename,
            "DISPLAY_NAME": attachment.displayName,
            "PADDING": "\(padding)",
            "CONTENT": content?.replacingOccurrences(of: "\n", with: "<br/>") ?? "null"
        ]
    }
}
