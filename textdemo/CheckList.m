//
//  CheckList.m
//  textdemo
//
//  Created by langker on 16/4/22.
//  Copyright © 2016年 langker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckList.h"
@implementation CheckList : List

-(void)dealWithDelete:(NSRange)range {
    if (range.location==0) return;
    NSMutableAttributedString *mutStr = [currentTextView.attributedText mutableCopy];
    if([mutStr containsAttachmentsInRange:NSMakeRange(range.location-1,1)]==TRUE) {
        int row = [self getWhichParaCursonIn];
        if (row>0)
            [mutStr deleteCharactersInRange:NSMakeRange(range.location-2,2)];
        else
            [mutStr deleteCharactersInRange:NSMakeRange(range.location-1,1)];
        currentTextView.attributedText = [mutStr copy];
    }
}

-(BOOL)isThisLineEmpty:(NSRange)range {
    NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
    
    int row = [self getWhichParaCursonIn];
    if ([result[row] length]==0)
        return FALSE;
    
    int loc = [self getParaLocCursonIn];
    NSMutableAttributedString *mutStr = [currentTextView.attributedText copy];
    if([mutStr containsAttachmentsInRange:NSMakeRange(loc,1)]==TRUE) {
        if (range.location==loc+1) {
            return TRUE;
        } else {
            return FALSE;
        }
    } else {
        return FALSE;
    }
}

-(void)addCheckList {
    [self deleteParaIndex];
    NSMutableAttributedString * mutStr = [currentTextView.attributedText mutableCopy];
    NSTextAttachment * attachment = [[NSTextAttachment alloc] init];
    attachment.bounds = CGRectMake(0, 0, 30, 30);
    attachment.image = [UIImage imageNamed:@"010"];
    [attachment.image setAccessibilityIdentifier:@"unchecked"];
    NSAttributedString * attachStr = [NSAttributedString attributedStringWithAttachment:attachment];
    
    int loc = [self getParaLocCursonIn];
    [mutStr insertAttributedString:attachStr atIndex:loc];
    currentTextView.attributedText = [mutStr copy];
}

-(void)deleteParaIndex {
    //NSRange range = currentTextView.selectedRange;
    if([self isParaContainIndex:currentTextView.selectedRange]==FALSE) return;
    int loc = [self getParaLocCursonIn];
    NSMutableAttributedString * mutStr = [currentTextView.attributedText mutableCopy];
    [mutStr deleteCharactersInRange:NSMakeRange(loc,1)];
    currentTextView.attributedText = [mutStr copy];
}

-(BOOL)isParaContainIndex:(NSRange)range {
    int loc = [self getParaLocCursonIn];
    NSMutableAttributedString *str = [currentTextView.attributedText mutableCopy];
    if(loc+1<=str.length &&[str containsAttachmentsInRange:NSMakeRange(loc, 1)]==TRUE) {
        return TRUE;
    } else {
        return FALSE;
    }
}
@end
