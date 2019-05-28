//
//  ArcticEditor.swift
//  ArcticEditor
//
//  Created by lcl on 2019/5/27.
//  Copyright © 2019 vuples. All rights reserved.
//

import Cocoa


enum ArcticEditorTextColor {
    case normal
    case funciton
    case variable
}


class ArcticEditor: NSView {
    var font = NSFont(name: "andale Mono", size: 18)
    var colors = [ArcticEditorTextColor.normal: NSColor.black]
    var cursorBegin = 0
    var cursorEnd = 0
    
    var text = "" {
        didSet {
            if text.last != "\n" {
                text.append("\n")
            }
        }
    }
}

extension ArcticEditor {
    override var acceptsFirstResponder: Bool { return true }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let context = getCGContext()
        let frame = getTextFrame(text: text, rect: dirtyRect)
        
        self.drawCursor(context: context, frame: frame)
        self.drawText(context: context, frame: frame)
        
    }
    
    func getTextFrame(text: String, rect: NSRect) -> CTFrame {
        let textString = text as CFString
        let attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0)
        CFAttributedStringReplaceString(attrString, CFRange(location: 0, length: 0), textString)
        CFAttributedStringSetAttribute(attrString, CFRange(location: 0, length: 3), kCTForegroundColorAttributeName, CGColor(red: 1, green: 0, blue: 0, alpha: 1))
        
        let path = CGMutablePath()
        path.addRect(rect)
        
        let framesetter = CTFramesetterCreateWithAttributedString(attrString!)
        return CTFramesetterCreateFrame(framesetter, CFRange(location: 0, length: 0), path, nil)
    }
    
    func getCGContext() -> CGContext {
        let context = NSGraphicsContext.current?.cgContext
        context?.textMatrix = .identity
        context?.setFillColor(CGColor(red: 1, green: 1, blue: 1, alpha: 1))
        
        return context!
    }
    
    func drawText(context: CGContext, frame: CTFrame) {
        CTFrameDraw(frame, context)
    }
    
    func drawCursor(context: CGContext, frame: CTFrame) {
        let cursorBeginLineIndex = ArcticEditor.getLineIndex(frame: frame, index: cursorBegin)
        let cursorEndLineIndex = ArcticEditor.getLineIndex(frame: frame, index: cursorEnd)

        if cursorBeginLineIndex == cursorEndLineIndex {
            let beginRect = ArcticEditor.getRect(frame: frame, index: cursorBegin, lineIndex: cursorBeginLineIndex).offsetBy(dx: -0.5, dy: 0)
            let endRect = ArcticEditor.getRect(frame: frame, index: cursorEnd, lineIndex: cursorEndLineIndex).offsetBy(dx: 0.5, dy: 0)
            let rect = beginRect.union(endRect)
            
            context.addRect(rect)
            context.fill(rect)
        }

    }
    

}

extension ArcticEditor {
    static func getLineIndex(frame: CTFrame, index: CFIndex) -> CFIndex {
        let lines = CTFrameGetLines(frame)

        for i in 0 ..< CFArrayGetCount(lines) {
            let curLine = unsafeBitCast(CFArrayGetValueAtIndex(lines, i)!, to: CTLine.self)
            let range = CTLineGetStringRange(curLine)
            if index >= range.location && index <= range.location + range.length {
                return i
            }
        }
        
        return 0
    }
    
    static func getRect(frame: CTFrame, index: CFIndex, lineIndex: CFIndex) -> CGRect {
        let lines = CTFrameGetLines(frame) as! Array<CTLine>
        var origins = [CGPoint] (repeating: .zero, count: lines.count)
        
        CTFrameGetLineOrigins(frame, CFRange(location: 0, length: 0), &origins)
        
        let originX = CTLineGetOffsetForStringIndex(lines[lineIndex], index, nil)
        let originY = origins[lineIndex].y
        let width: CGFloat = 0.0
        let height = origins[lineIndex].y - origins[lineIndex + 1].y

        return CGRect(x: originX, y: originY, width: width, height: height)
    }
    
}
extension ArcticEditor {
    override func keyDown(with event: NSEvent) {
        let char = event.characters ?? ""
        let rangeBegin = text.index(text.startIndex, offsetBy: cursorBegin)
        let rangeEnd = text.index(text.startIndex, offsetBy: cursorEnd)
        
        text.replaceSubrange(rangeBegin..<rangeEnd, with: char)
        cursorBegin += 1
        cursorEnd += 1
        
        self.setNeedsDisplay(self.bounds)
    }
}
