//
//  TestVideo.swift
//  XCTestHTMLReport
//

import Foundation

struct TestVideo: HTML {
    let videoPath: String
    let padding: Int

    init?(identifier: String, in directory: String?, padding: Int) {
        guard let directory = directory else { return nil }

        let name = identifier[..<identifier.index(identifier.endIndex, offsetBy: -2)]
            .replacingOccurrences(of: "/", with: "-")
        let fullPath = URL(fileURLWithPath: directory)
            .appendingPathComponent(name)
            .appendingPathExtension("mp4")
            .path

        guard FileManager.default.fileExists(atPath: fullPath) else { return nil }

        videoPath = URL(fileURLWithPath: directory)
            .lastPathComponent
            .appending("/\(name).mp4")
        self.padding = padding
    }

    var htmlTemplate: String {
        return """
        <p class=\"attachment list-item\">
          <span class=\"icon left screenshot-icon\" style=\"margin-left: [[PADDING]]px\"></span>
          Video
          <span class=\"icon preview-icon\" data=\"[[FILENAME]]\" onclick=\"showVideo('[[FILENAME]]')\"></span>
          <video class=\"video\" src=\"[[SRC]]\" id=\"video-[[FILENAME]]\"/>
        </p>
        """
    }

    var htmlPlaceholderValues: [String: String] {
        return [
            "PADDING": "\(padding)",
            "SRC": videoPath,
            "FILENAME": (videoPath as NSString).lastPathComponent
        ]
    }
}
