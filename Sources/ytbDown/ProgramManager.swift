//
//  ProgramManager.swift
//  ytbDown
//
//  Created by Yassir RAMDANI on 6/22/19.
//

import Foundation

struct ProgramManager {
    var Options: [String: (Int) -> Void]!
    let downloader = ytbDownloader()
    init() {
        Options = ["-h": self.help,
                   "-d": self.download,
                   "-n": self.changeName]
    }
    
    let OptionsDescription = ["-h": "Show help",
                              "-d <videoId>": "Downloads youtube video with id <videoId>",
                              "-n <fileName>": "Sets the name of the downloaded video to <fileName> (<videoID> is default name)"]
    
    func help(_: Int) {
        print("Usage: ./ytbDownloader [-n <fileName>] -d <videoId>")
        let optionSizeMax = (OptionsDescription.keys.max(by: { $0.count < $1.count })?.count ?? 0)
        for op in OptionsDescription {
            print("\t\t\(op.key) \(repeatElement(" ", count: optionSizeMax - op.key.count).joined()): \(op.value)")
        }
    }
    
    func download(_ index: Int) {
        let videoId = CommandLine.arguments[index + 1]
        let sema = DispatchSemaphore(value: 0)
        var link = ""
        print("-> Checking link")
        YoutubeVideoUrlExtractor.extractVideos(from: videoId) { (dic) -> Void in
            if dic.count == 0 {
                print("⚠️ : Video not found! please insert only the videoId of the video.")
                sema.signal()
                exit(1)
            }
            link = dic.first?.value ?? ""
            print(dic)
            self.downloader.downloadLink(link: link, videoId: videoId, sem: sema)
        }
        sema.wait()
    }
    
    func handleOptions() {
        if CommandLine.argc == 1 {
            return
        } else {
            if CommandLine.argc > 1 {
                for j in 1 ..< Int(CommandLine.argc) {
                    if let option = Options.first(where: { $0.key == CommandLine.arguments[j] }) {
                        let f = option.value
                        f(j)
                    }
                }
            }
        }
    }
    
    func changeName(_ index: Int) {
        downloader.name = CommandLine.arguments[index + 1]
    }
}
