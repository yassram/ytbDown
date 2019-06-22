//
//  ytbDownloader.swift
//  ytbDown
//
//  Created by Yassir RAMDANI on 6/22/19.
//

import Foundation

class ytbDownloader {
    var name: String?
    fileprivate var downloadTask: URLSessionDownloadTask!
    
    func downloadLink(link: String, videoId: String, sem: DispatchSemaphore) {
        let linkURL = URL(string: link)!
        print("-> Starting Download!")
        downloadTask = URLSession.shared.downloadTask(with: linkURL) { url, _, error in
            guard error == nil else {
                fputs("❌ : \(error!.localizedDescription)\n\n", stderr)
                sem.signal()
                return
            }
            guard let url = url else {
                sem.signal()
                return
            }
            
            do {
                print("-> Completed!")
                try FileManager().copyItem(at: url,
                                           to: URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent((self.name ?? videoId) + ".mp4", isDirectory: true))
                sem.signal()
                
            } catch let err {
                print("⚠️ : \(err.localizedDescription)")
                sem.signal()
            }
        }
        downloadTask.resume()
        var i = 0
        print()
        while true {
            i += 1
            if #available(OSX 10.13, *) {
                let progress = downloadTask.progress.fractionCompleted
                printProgress(progress: progress)
                sleep(0)
                if progress == 1 {
                    printProgress(progress: 1)
                    break
                }
            } else {
                // Fallback on earlier versions
                sleep(1)
                break
            }
        }
    }
    
    fileprivate func printProgress(progress: Double) {
        print("\u{1B}[1A\u{1B}[K\("[\(repeatElement("-", count: Int(progress) * 15).joined())\(repeatElement(" ", count: 15 - Int(progress) * 15).joined())]")")
    }
}
