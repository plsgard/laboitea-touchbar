//
//  ViewController.swift
//  LaBoiteA
//
//  Created by Pier-Lionel Sgard on 06/12/2018.
//  Copyright © 2018 Diple. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        if #available(macOS 10.12.2, *) {
            sounds = Lopez.fileList.map { Sound.ConvertTo(input: $0) }
        }
    }
    
    var sounds: [Sound] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    var player:AVPlayer?
    func playSound(named link: URL) {
        player = AVPlayer.init(url: link)
        player?.play()
    }
    
    fileprivate lazy var scrubber: NSScrubber = {
        let s = NSScrubber()
        
        let layout = NSScrubberFlowLayout()
        layout.itemSize = NSSize(width: 150, height: 30)
        layout.itemSpacing = 1.0
        
        s.scrubberLayout = layout
        s.selectionOverlayStyle = .outlineOverlay
        s.mode = .free
        s.showsAdditionalContentIndicators = true
        s.dataSource = self
        s.delegate = self
        s.autoresizingMask = [.width, .height]
        s.register(NSScrubberTextItemView.self, forItemIdentifier: NSUserInterfaceItemIdentifier(rawValue: Constants.itemIdentifier))
        
        return s
    }()
    
    func didSelectLink(_ linkURL: URL) {
        playSound(named: linkURL)
    }
}

@available(OSX 10.12.2, *)
extension ViewController: NSScrubberDataSource, NSScrubberDelegate {
    
    struct Constants {
        static let itemIdentifier = "scrubberItem"
    }
    
    func numberOfItems(for scrubber: NSScrubber) -> Int {
        return sounds.count
    }
    
    func scrubber(_ scrubber: NSScrubber, viewForItemAt index: Int) -> NSScrubberItemView {
        var item = scrubber.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: Constants.itemIdentifier), owner: scrubber) as? NSScrubberTextItemView
        
        if item == nil {
            item = NSScrubberTextItemView()
            item?.identifier = NSUserInterfaceItemIdentifier(rawValue: Constants.itemIdentifier)
        }
        
        item?.textField.stringValue = sounds[index].name
        
        return item ?? NSScrubberItemView()
    }
    
    func scrubber(_ scrubber: NSScrubber, didSelectItemAt selectedIndex: Int) {
        guard selectedIndex < scrubber.numberOfItems else { return }
        
        let selectedItem = sounds[selectedIndex]
        let link = selectedItem.link
        
        didSelectLink(link)
    }
}

@available(OSX 10.12.1, *)
extension ViewController: NSTouchBarDelegate {
    
    override func makeTouchBar() -> NSTouchBar? {
        
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        
        touchBar.customizationIdentifier = NSTouchBar.CustomizationIdentifier.lopezBar
        
        touchBar.defaultItemIdentifiers = [NSTouchBarItem.Identifier.scrollBar]
        touchBar.customizationAllowedItemIdentifiers = [NSTouchBarItem.Identifier.scrollBar]
        
        return touchBar
    }
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case NSTouchBarItem.Identifier.scrollBar:
            let item = NSCustomTouchBarItem(identifier: NSTouchBarItem.Identifier.scrollBar)
            item.view = scrubber
            return item
        default:
            return nil
        }
    }
}
