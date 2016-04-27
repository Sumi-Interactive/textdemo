//
//  ListController.h
//  textdemo
//
//  Created by langker on 16/4/25.
//  Copyright © 2016年 langker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "OrderList.h"
#import "UnorderList.h"
#import "CheckList.h"

typedef NS_ENUM(NSInteger,typingType){
    NONESTYLE = 0,
    CHECKLIST = 1,
    ORDERLIST = 2,
    UNORDERLIST = 3
};

@interface ListController : NSObject {
    UITextView *currentTextView;
    OrderList *orderList;
    UnorderList *unorderList;
    CheckList *checkList;
    int typingMode;
}

-(id)init:(UITextView *)textView;

-(void)addUnorderList;

-(void)addOrderList;

-(void)addCheckList;

-(BOOL)isThisLineEmpty:(NSRange)range;

-(void)dealWithDelete:(NSRange)range;

-(void)deleteParaIndex;

-(int)getTypingMode;

-(void)changeTypingMode;

@end
