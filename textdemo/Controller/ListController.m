//
//  ListController.m
//  textdemo
//
//  Created by langker on 16/4/25.
//  Copyright © 2016年 langker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListController.h"

@implementation ListController:NSObject
-(id)init:(UITextView *)textView {
    if((self = [super init])) {
        currentTextView = textView;
        orderList = [[OrderList alloc] init:currentTextView];
        unorderList = [[UnorderList alloc] init:currentTextView];
        checkList = [[CheckList alloc] init:currentTextView];
        typingMode = NONESTYLE;
    }
    return self;
    
}
-(BOOL)isThisLineEmpty:(NSRange)range {
    switch([self getParaMode:range]) {
        case ORDERLIST:
            return [orderList isThisLineEmpty:range];
        case UNORDERLIST:
            return [unorderList isThisLineEmpty:range];
        case CHECKLIST:
            return [checkList isThisLineEmpty:range];
        default:
            return FALSE;
    }
}

-(void)deleteParaIndex {
    [orderList deleteParaIndex];
    [unorderList deleteParaIndex];
    [checkList deleteParaIndex];
}

-(void)dealWithDelete:(NSRange)range {
    switch([self getParaMode:range]) {
        case UNORDERLIST:
            [unorderList dealWithDelete:range];
            break;
        case ORDERLIST:
            [orderList dealWithDelete:range];
            break;
        case CHECKLIST:
            [checkList dealWithDelete:range];
            break;
    }
}
-(int)getParaMode:(NSRange)range {
    if ([orderList isParaContainIndex:currentTextView.selectedRange]) {
        return ORDERLIST;
    } else if([unorderList isParaContainIndex:currentTextView.selectedRange]) {
        return UNORDERLIST;
    } else if ([checkList isParaContainIndex:currentTextView.selectedRange]) {
        return CHECKLIST;
    } else {
        return NONESTYLE;
    }
}
-(void)addUnorderList {
    [self deleteParaIndex];
    [unorderList addUnorderList];
}

-(void)addOrderList {
    [self deleteParaIndex];
    [orderList addOrderList];
}

-(void)addCheckList {
    [self deleteParaIndex];
    [checkList addCheckList];
}

-(void)changeTypingMode {
    if ([orderList isParaContainIndex:currentTextView.selectedRange]) {
        typingMode = ORDERLIST;
    } else if([unorderList isParaContainIndex:currentTextView.selectedRange]) {
        typingMode = UNORDERLIST;
    } else if ([checkList isParaContainIndex:currentTextView.selectedRange]) {
        typingMode = CHECKLIST;
    } else {
        typingMode = NONESTYLE;
    }
}
-(int)getTypingMode {
    return typingMode;
}
@end
