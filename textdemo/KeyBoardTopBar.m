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


//初始化控件和变量

-(id)init{
    
    if((self = [super init])) {
        
        prevButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一项" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowPrevious)];
        
        nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一项" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowNext)];
        
        hiddenButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏键盘" style:UIBarButtonItemStyleBordered target:self action:@selector(HiddenKeyBoard)];
        
        spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        view = [[UIToolbar alloc] initWithFrame:CGRectMake(0,-44,420,44)];
        
        view.barStyle = UIBarStyleDefault;
        
        view.items = [NSArray arrayWithObjects:prevButtonItem,nextButtonItem,spaceButtonItem,hiddenButtonItem,nil];
        
        
        allowShowPreAndNext = YES;
        
        textFields = nil;
        
        isInNavigationController = YES;
        
        currentTextField = nil;
        
    }
    
    return self;
    
}

//设置是否在导航视图中

-(void)setIsInNavigationController:(BOOL)isbool{
    
    isInNavigationController = isbool;
    
}

//显示上一项

-(void)showPrevious{
    
    if (textFields==nil) {
        
        return;
        
    }
    
    NSInteger num = -1;
    
    for (NSInteger i=0; i<[textFields count]; i++) {
        
        if ([textFields objectAtIndex:i]==currentTextField) {
            
            num = i;
            
            break;
            
        }
        
    }
    
    if (num>0){
        
        [[textFields objectAtIndex:num] resignFirstResponder];
        
        [[textFields objectAtIndex:num-1 ] becomeFirstResponder];
        
        [self showBar:[textFields objectAtIndex:num-1]];
        
    }
    
}

//显示下一项

-(void)showNext{
    
    if (textFields==nil) {
        
        return;
        
    }
    
    NSInteger num = -1;
    
    for (NSInteger i=0; i<[textFields count]; i++) {
        
        if ([textFields objectAtIndex:i]==currentTextField) {
            
            num = i;
            
            break;
            
        }
        
    }
    
    if (num<[textFields count]-1){
        
        [[textFields objectAtIndex:num] resignFirstResponder];
        
        [[textFields objectAtIndex:num+1] becomeFirstResponder];
        
        [self showBar:[textFields objectAtIndex:num+1]];
        
    }
    
}

//显示工具条

-(void)showBar:(UITextField *)textField{
    
    currentTextField = textField;
    
    if (allowShowPreAndNext) {
        
        [view setItems:[NSArray arrayWithObjects:prevButtonItem,nextButtonItem,spaceButtonItem,hiddenButtonItem,nil]];
        
    }
    
    else {
        
        [view setItems:[NSArray arrayWithObjects:spaceButtonItem,hiddenButtonItem,nil]];
        
    }
    
    if (textFields==nil) {
        
        prevButtonItem.enabled = NO;
        
        nextButtonItem.enabled = NO;
        
    }
    
    else {
        
        NSInteger num = -1;
        
        for (NSInteger i=0; i<[textFields count]; i++) {
            
            if ([textFields objectAtIndex:i]==currentTextField) {
                
                num = i;
                
                break;
                
            }
            
        }
        
        if (num>0) {
            
            prevButtonItem.enabled = YES;
            
        }
        
        else {
            
            prevButtonItem.enabled = NO;
            
        }
        
        if (num<[textFields count]-1) {
            
            nextButtonItem.enabled = YES;
            
        }
        
        else {
            
            nextButtonItem.enabled = NO;
            
        }
        
    }
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.3];
    
    if (isInNavigationController) {
        
        view.frame = CGRectMake(0, 201-40, 420, 44);
        
    }
    
    else {
        
        view.frame = CGRectMake(0, 420, 420, 44);
        
    }
    
    [UIView commitAnimations];
    
}

//设置输入框数组

-(void)setTextFieldsArray:(NSArray *)array{
    
    textFields = array;
    
}

//设置是否显示上一项和下一项按钮

-(void)setAllowShowPreAndNext:(BOOL)isShow{
    
    allowShowPreAndNext = isShow;
    
}

//隐藏键盘和工具条

-(void)HiddenKeyBoard{
    
    if (currentTextField!=nil) {
        
        [currentTextField  resignFirstResponder];
        
    }
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.3];
    
    view.frame = CGRectMake(0, -44, 420, 44);
    view.barStyle = UIBarStyleDefault;
    [UIView commitAnimations];
    
}

- (void)dealloc {
    
//    [view release];
//    
//    [textFields release];
//    
//    [prevButtonItem release];
//    
//    [nextButtonItem release];
//    
//    [hiddenButtonItem release];
//    
//    [currentTextField release];
//    
//    [spaceButtonItem release];
//    
//    [super dealloc];
    
}

@end