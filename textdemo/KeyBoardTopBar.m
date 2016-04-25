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
@synthesize list;

-(id)init:(UITextView *)textView {
    
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
        
        currentTextView = textView;
        
        list = [[ListController alloc] init:currentTextView];
        
        style = [[StyleController alloc] init:currentTextView];
        
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
    }
    
    return self;
    
}

-(void)addOrderList {
    [list addOrderList];
}

-(void)addUnorderList {
    [list addUnorderList];
}
-(void)addCheckButton {
    [list addCheckList];
}

-(void)changeTextToBigTitle {
    [style setTextSize:30];
}

-(void)changeTextToSmallTitle {
    [style setTextSize:25];
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

@end