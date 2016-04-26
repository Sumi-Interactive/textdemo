//
//  StyleController.m
//  textdemo
//
//  Created by langker on 16/4/25.
//  Copyright © 2016年 langker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StyleController.h"

@implementation StyleController:NSObject

-(id)init:(UITextView *)textView {
    if((self = [super init])) {
        currentTextView = textView;
        style = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)setTextSize:(int)textSize {
    if (currentTextView.selectedRange.length==0) {
        if ([style valueForKey:NSFontAttributeName]==nil){
            [style setValue:[UIFont systemFontOfSize:textSize] forKey:NSFontAttributeName];
            currentTextView.typingAttributes = style;
        } else {
            [self resetTextStyle];
        }
    } else {
        NSMutableAttributedString *text =[currentTextView.attributedText mutableCopy];
        NSDictionary *dic = [text attributesAtIndex:currentTextView.selectedRange.location effectiveRange:nil];
        if ((int)((UIFont *)[dic valueForKey:NSFontAttributeName]).pointSize==30 &&
            textSize==30) {
            [self resetTextStyle];
        } else if((int)((UIFont *)[dic valueForKey:NSFontAttributeName]).pointSize==25 &&
            textSize==25) {
            [self resetTextStyle];
        } else {
            [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:textSize] range:currentTextView.selectedRange];
            NSUInteger tmpLocation = currentTextView.selectedRange.location;
            NSUInteger tmpLength = currentTextView.selectedRange.length;
            currentTextView.attributedText = [text copy];
            currentTextView.selectedRange = NSMakeRange(tmpLocation, tmpLength);
        }
    }
}

-(void)resetTextStyle {
    if (currentTextView.selectedRange.length==0) {
        [style removeObjectForKey:NSFontAttributeName];
        currentTextView.typingAttributes = style;
    } else {
        
        NSMutableAttributedString *text =[currentTextView.attributedText mutableCopy];
        [text removeAttribute:NSFontAttributeName range:currentTextView.selectedRange];
        [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:currentTextView.selectedRange];
        NSUInteger tmpLocation = currentTextView.selectedRange.location;
        NSUInteger tmpLength = currentTextView.selectedRange.length;
        currentTextView.attributedText = [text copy];
        currentTextView.selectedRange = NSMakeRange(tmpLocation, tmpLength);
        
    }
}
@end
