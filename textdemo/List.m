//
//  List.m
//  textdemo
//
//  Created by langker on 16/4/22.
//  Copyright © 2016年 langker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "List.h"

@implementation List:NSObject
-(id)init:(UITextView *)textView {
    if((self = [super init])) {
        currentTextView = textView;
    }
    return self;
}
-(int) getWhichParaCursonIn {
    NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
    int count = (int)result.count;
    int loc = (int)currentTextView.selectedRange.location;
    int row = 0;
    NSMutableArray *offset = [[NSMutableArray alloc] init];
    for (int i=0,foo=0; i<count; i++) {
        [offset addObject:[NSNumber numberWithInt:foo]];
        foo = foo + (int)[result[i] length] + 1;
        if (count-1==i)
            [offset addObject:[NSNumber numberWithInt:foo]];
    }
    
    for (int i=0; i<count; i++) {
        
        if ( loc>=[offset[i] intValue]&&loc<[offset[i+1] intValue]) {
            row = i;
            break;
        }
    }
    return row;
}

-(int) getParaLocCursonIn {
    NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
    int count = (int)result.count;
    int loc = (int)currentTextView.selectedRange.location;
    int row = 0;
    NSMutableArray *offset = [[NSMutableArray alloc] init];
    for (int i=0,foo=0; i<count; i++) {
        [offset addObject:[NSNumber numberWithInt:foo]];
        foo = foo + (int)[result[i] length] + 1;
        if (count-1==i)
            [offset addObject:[NSNumber numberWithInt:foo]];
    }
    
    for (int i=0; i<count; i++) {
        
        if ( loc>=[offset[i] intValue]&&loc<[offset[i+1] intValue]) {
            row = [offset[i] intValue];
            break;
        }
    }
    return row;
}

-(void)editAttributeString:(NSString*)text :(NSRange)range{
    NSMutableAttributedString *replace = [currentTextView.attributedText mutableCopy];
    [replace.mutableString replaceCharactersInRange:range withString:text];
    currentTextView.attributedText  = [replace copy];
}

-(BOOL)isParaContainIndex:(NSRange)range {
    NSMutableArray *result = [[currentTextView.attributedText.string componentsSeparatedByString:@"\n"] mutableCopy];
    int row = [self getWhichParaCursonIn];
    int loc = [self getParaLocCursonIn];
    NSMutableAttributedString *str = [currentTextView.attributedText mutableCopy];
    if ([result[row] componentsSeparatedByString:@"."][0].intValue!=0) {
        return TRUE;
    } else if([result[row] length]>=2 && [[result[row] substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"- "]) {
        return TRUE;
    } else if(loc+1<=str.length &&[str containsAttachmentsInRange:NSMakeRange(loc, 1)]==TRUE) {
        return TRUE;
    } else {
        return FALSE;
    }
}

@end
