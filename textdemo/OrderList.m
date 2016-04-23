//
//  OrderList.m
//  textdemo
//
//  Created by langker on 16/4/22.
//  Copyright © 2016年 langker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderList.h"
@implementation OrderList : List

-(void)dealWithDelete:(NSRange)range {
    if (range.location==0) return;
    NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
    
    int row = [self getWhichParaCursonIn];
    int locOfPara = [self getParaLocCursonIn];
    int locOfIndex= (int)[result[row] componentsSeparatedByString:@"."][0].length+2;
    if (locOfPara+locOfIndex==range.location) {
        NSMutableAttributedString * mutStr = [currentTextView.attributedText mutableCopy];
        if (locOfPara>0)
            [mutStr deleteCharactersInRange:NSMakeRange(locOfPara-1,locOfIndex+1)];
        else
            [mutStr deleteCharactersInRange:NSMakeRange(locOfPara,locOfIndex)];
        currentTextView.attributedText = [mutStr copy];
        
        for(int j=row+1;j<result.count;j++) {
            int tmp = [result[j] componentsSeparatedByString:@"."][0].intValue;
            if (tmp!=0) {
                NSRange range = [currentTextView.attributedText.string rangeOfString:result[j]];
                NSMutableAttributedString *replace = [currentTextView.attributedText mutableCopy];
                NSMutableString *text = [NSMutableString stringWithString:result[j]];
                NSString *newIndexLength = [NSString stringWithFormat:@"%d .",tmp];
                NSString *newIndex = [NSString stringWithFormat:@"%d. ",tmp-1];
                [text replaceCharactersInRange:NSMakeRange(0, newIndexLength.length) withString:newIndex];
                
                [replace.mutableString replaceCharactersInRange:range withString:text];
                currentTextView.attributedText  = [replace copy];
            }
        }
    }
}

-(BOOL)isThisLineEmpty:(NSRange)range {
    NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
    
    int row = [self getWhichParaCursonIn];
    if ([result[row] length]==0)
        return FALSE;
    
    int loc = [self getParaLocCursonIn];
    int number = (int)[result[row] componentsSeparatedByString:@"."][0].intValue;
    int locOfIndex= (int)[result[row] componentsSeparatedByString:@"."][0].length+1;
    if (number!=0) {
        if (loc+locOfIndex+1==range.location) {
            return TRUE;
        } else {
            return FALSE;
        }
    } else {
        return FALSE;
    }
}

-(void)addOrderList {
    [self deleteParaIndex];
    NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
    
    int row = [self getWhichParaCursonIn];
    int loc = [self getParaLocCursonIn];
    
    int i = 1 ;
    
    if (row!=0) {
        int number = [result[row-1] componentsSeparatedByString:@"."][0].intValue;
        if (number==0) {
            i = 1;
        } else {
            i = number+1;
        }
    }
    
    NSString *replace = [NSString stringWithFormat:@"%d. %@",i,result[row]];
    [self editAttributeString:replace :NSMakeRange(loc, [result[row] length])];
    
    int offset = loc + (int)replace.length+1;
    for(int j=row+1;j<result.count;j++) {
        int tmp = [result[j] componentsSeparatedByString:@"."][0].intValue;
        if (tmp!=0){
            
            NSMutableAttributedString *replace = [currentTextView.attributedText mutableCopy];
            NSMutableString *text = [NSMutableString stringWithString:result[j]];
            NSString *newIndexLength = [NSString stringWithFormat:@"%d .",tmp];
            NSString *newIndex = [NSString stringWithFormat:@"%d. ",tmp+1];
            [text replaceCharactersInRange:NSMakeRange(0, newIndexLength.length) withString:newIndex];
            
            NSRange range = NSMakeRange(offset,[text length]);
            [replace.mutableString replaceCharactersInRange:range withString:text];
            currentTextView.attributedText  = [replace copy];
            offset = offset + (int)[text length]+1;
        } else {
            break;
        }
    }

}

-(void)deleteParaIndex {
    if([self isParaContainIndex:currentTextView.selectedRange]==FALSE)
        return;
    NSRange range = currentTextView.selectedRange;
    NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
    int row = [self getWhichParaCursonIn];
    int loc = [self getParaLocCursonIn];
    int locOfIndex= (int)[result[row] componentsSeparatedByString:@"."][0].length+1;

    NSMutableAttributedString * mutStr = [currentTextView.attributedText mutableCopy];
    [mutStr deleteCharactersInRange:NSMakeRange(loc,locOfIndex+1)];
    currentTextView.attributedText = [mutStr copy];
    range.location = range.location - locOfIndex-1;
    currentTextView.selectedRange = range;
}

-(BOOL)isParaContainIndex:(NSRange)range {
    NSMutableArray *result = [[currentTextView.attributedText.string componentsSeparatedByString:@"\n"] mutableCopy];
    int row = [self getWhichParaCursonIn];
    if ([result[row] componentsSeparatedByString:@"."][0].intValue!=0) {
        return TRUE;
    } else {
        return FALSE;
    }
}
@end