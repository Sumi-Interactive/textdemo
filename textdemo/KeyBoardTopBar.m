//
//  KeyBoardTopBar.m
//  textdemo
//
//  Created by langker on 16/4/11.
//  Copyright © 2016年 langker. All rights reserved.
//

#import "KeyBoardTopBar.h"

@implementation KeyBoardTopBar

@synthesize view;

-(id)init:(UITextView *)textView{
    
    if((self = [super init])) {
        
        bigTitleButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"大标题" style:UIBarButtonItemStylePlain target:self action:@selector(changeTextToBigTitle)];
        
        smallTitleButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"小标题" style:UIBarButtonItemStylePlain target:self action:@selector(changeTextToSmallTitle)];
        
        orderListButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"有序" style:UIBarButtonItemStylePlain target:self action:@selector(addOrderList)];
        
        unorderListButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"无序" style:UIBarButtonItemStylePlain target:self action:@selector(addUnorderList)];
        
        checkListButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"核查" style:UIBarButtonItemStylePlain target:self action:@selector(addCheckButton)];
        
        hiddenButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏键盘" style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyBoard)];
        
        spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        view = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,400,44)];
        
        view.barStyle = UIBarStyleDefault;
        
        style = [[NSMutableDictionary alloc] init];
        
        currentTextView = textView;
        
        [view setItems:[NSArray arrayWithObjects:
                        bigTitleButtonItem,
                        smallTitleButtonItem,
                        orderListButtonItem,
                        unorderListButtonItem,
                        checkListButtonItem,
                        spaceButtonItem,
                        hiddenButtonItem,
                        nil]];
        
        currentTextView.inputAccessoryView = view;
        
        orderList = [[OrderList alloc] init:currentTextView];
        unorderList = [[UnorderList alloc] init:currentTextView];
        checkList = [[CheckList alloc] init:currentTextView];
        
        typingMode = NONESTYLE;
        
    }
    
    return self;
    
}

-(void)addOrderList {
    [self deleteParaIndex];
    [orderList addOrderList];
    typingMode = ORDERLIST;
}

-(void)addUnorderList {
    [self deleteParaIndex];
    [unorderList addUnorderList];
    typingMode = UNORDERLIST;
}
-(void)addCheckButton {
    [self deleteParaIndex];
    [checkList addCheckList];
    typingMode = CHECKLIST;
}

-(void)changeTextToBigTitle {
    [self dealWithTitle:30];
}


-(void)changeTextToSmallTitle {
    [self dealWithTitle:25];
}

-(void) dealWithTitle:(int)font {
    if (currentTextView.selectedRange.length==0) {
        [style setValue:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName];
        [self changeTextFontStyle];
    } else {
        
        NSMutableAttributedString *text =[currentTextView.attributedText mutableCopy];
        [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(currentTextView.selectedRange.location, currentTextView.selectedRange.length)];
        
        NSUInteger tmpLocation = currentTextView.selectedRange.location;
        NSUInteger tmpLength = currentTextView.selectedRange.length;
        currentTextView.attributedText = [text copy];
        currentTextView.selectedRange = NSMakeRange(tmpLocation, tmpLength);
        
    }
}
-(void)changeTextFontStyle {
    currentTextView.typingAttributes = style;
}

-(void)hideKeyBoard {
    
    if (currentTextView!=nil) {
        
        [currentTextView  resignFirstResponder];
        
    }
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.3];
    
    view.barStyle = UIBarStyleDefault;
    [UIView commitAnimations];
    
}

-(int)getTypingMode {
    return typingMode;
}

-(void)setTypingMode:(int)mode {
    typingMode = mode;
}

-(void)dealWithDelete:(NSRange)range {
    switch([self getTypingMode]) {
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

-(BOOL)isThisLineEmpty:(NSRange)range {
    switch([self getTypingMode]) {
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

@end