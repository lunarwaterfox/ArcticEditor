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
    var text = ""
    var font = NSFont(name: "andale Mono", size: 18)
    var colors = [ArcticEditorTextColor.normal: NSColor.black]
    var cursorBegin = 0
    var cursorEnd = 0
}

extension ArcticEditor {
    override var acceptsFirstResponder: Bool { return true }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
//        let attr = [NSAttributedString.Key.foregroundColor : colors[.normal]!,
//                    NSAttributedString.Key.font : font!]
//        let wcnm = NSAttributedString(string: text, attributes: attr)
//        wcnm.draw(in: dirtyRect)
        // Drawing code here.
        let context = getcontexnt
        
        // Initialize a graphics context in iOS.
//        CGContextRef context = UIGraphicsGetCurrentContext();
//
//        // Flip the context coordinates, in iOS only.
//        CGContextTranslateCTM(context, 0, self.bounds.size.height);
//        CGContextScaleCTM(context, 1.0, -1.0);
//
//        // Initializing a graphic context in OS X is different:
//        // CGContextRef context =
//        //     (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
//
//        // Set the text matrix.
//        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//
//        // Create a path which bounds the area where you will be drawing text.
//        // The path need not be rectangular.
//        CGMutablePathRef path = CGPathCreateMutable();
//
//        // In this simple example, initialize a rectangular path.
//        CGRect bounds = CGRectMake(10.0, 10.0, 200.0, 200.0);
//        CGPathAddRect(path, NULL, bounds );
//
//        // Initialize a string.
//        CFStringRef textString = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
//
//        // Create a mutable attributed string with a max length of 0.
//        // The max length is a hint as to how much internal storage to reserve.
//        // 0 means no hint.
//        CFMutableAttributedStringRef attrString =
//            CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
//
//        // Copy the textString into the newly created attrString
//        CFAttributedStringReplaceString (attrString, CFRangeMake(0, 0),
//                                         textString);
//
//        // Create a color that will be added as an attribute to the attrString.
//        CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
//        CGFloat components[] = { 1.0, 0.0, 0.0, 0.8 };
//        CGColorRef red = CGColorCreate(rgbColorSpace, components);
//        CGColorSpaceRelease(rgbColorSpace);
//
//        // Set the color of the first 12 chars to red.
//        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 12),
//                                       kCTForegroundColorAttributeName, red);
//
//        // Create the framesetter with the attributed string.
//        CTFramesetterRef framesetter =
//            CTFramesetterCreateWithAttributedString(attrString);
//        CFRelease(attrString);
//
//        // Create a frame.
//        CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
//                                                    CFRangeMake(0, 0), path, NULL);
//
//        // Draw the specified frame in the given context.
//        CTFrameDraw(frame, context);
//
//        // Release the objects we used.
//        CFRelease(frame);
//        CFRelease(path);
//        CFRelease(framesetter);
        
        let wcnm = Cfattr

    }
    
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
