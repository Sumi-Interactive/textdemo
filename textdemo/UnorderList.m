//
//  UnorderList.m
//  textdemo
//
//  Created by langker on 16/4/22.
//  Copyright © 2016年 langker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnorderList.h"
@implementation UnorderList : List

-(BOOL)dealWithDelete:(NSRange)range {
    if (range.location<2) return TRUE;
    NSAttributedString *firstCharOfPara = [currentTextView.attributedText attributedSubstringFromRange:NSMakeRange(range.location-2,2)];
    if ([firstCharOfPara.string isEqualToString:@"- "]) {
        NSMutableAttributedString * mutStr = [currentTextView.attributedText mutableCopy];
        [mutStr deleteCharactersInRange:NSMakeRange(range.location-2,2)];
        currentTextView.attributedText = [mutStr copy];
        return FALSE;
    } else {
        return TRUE;
    }
}

-(BOOL)isThisLineEmpty:(NSRange)range {
    NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
    
    int row = [self getWhichParaCursonIn];
    if ([result[row] length]==0)
        return FALSE;
    
    int loc = [self getParaLocCursonIn];

    NSAttributedString *firstCharOfPara = [currentTextView.attributedText attributedSubstringFromRange:NSMakeRange(loc,2)];
    if ([firstCharOfPara.string isEqualToString:@"- "]) {
        if (loc+2==range.location) {
            return TRUE;
        } else {
            return FALSE;
        }
    } else {
        return FALSE;
    }
}

-(void)addUnorderList {
    [self deleteParaIndex];
    NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
    
    int row = [self getWhichParaCursonIn];
    int loc = [self getParaLocCursonIn];
    
    NSString *replace = [NSString stringWithFormat:@"- %@",result[row]];
    
    [self editAttributeString:replace :NSMakeRange(loc, [result[row] length]) ];
}

-(void)deleteParaIndex {
    NSRange range = currentTextView.selectedRange;
    if([self isParaContainIndex:currentTextView.selectedRange]==FALSE) return;
    int loc = [self getParaLocCursonIn];
    NSMutableAttributedString * mutStr = [currentTextView.attributedText mutableCopy];
    [mutStr deleteCharactersInRange:NSMakeRange(loc,2)];
    currentTextView.attributedText = [mutStr copy];
    range.location-=2;
    currentTextView.selectedRange = range;
};

-(BOOL)isParaContainIndex:(NSRange)range {
    NSMutableArray *result = [[currentTextView.attributedText.string componentsSeparatedByString:@"\n"] mutableCopy];
    int row = [self getWhichParaCursonIn];
    if([result[row] length]>=2 && [[result[row] substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"- "]) {
        return TRUE;
    } else {
        return FALSE;
    }
}
@end
