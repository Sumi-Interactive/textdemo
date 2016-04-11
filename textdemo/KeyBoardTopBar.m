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
        
        prevButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"变绿" style:UIBarButtonItemStylePlain target:self action:@selector(changeTextColorToYellow)];
        
        nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"加粗" style:UIBarButtonItemStylePlain target:self action:@selector(changeTextStyleToBold)];
        
        hiddenButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏键盘" style:UIBarButtonItemStylePlain target:self action:@selector(HiddenKeyBoard)];
        
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


-(void)changeTextColorToYellow{
    NSString *str = @"bold，little color，hello";
    
    //NSMutableAttributedString的初始化
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str attributes:attrs];
    
    //NSMutableAttributedString增加属性
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:36] range:[str rangeOfString:@"bold"]];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:[str rangeOfString:@"little color"]];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Papyrus" size:36] range:NSMakeRange(18,5)];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:[str rangeOfString:@"little"]];
    
    //NSMutableAttributedString移除属性
    [attributedString removeAttribute:NSFontAttributeName range:[str rangeOfString:@"little"]];
    
    //NSMutableAttributedString设置属性
    NSDictionary *attrs2 = @{NSStrokeWidthAttributeName:@-5,
                             NSStrokeColorAttributeName:[UIColor greenColor],
                             NSFontAttributeName:[UIFont systemFontOfSize:36],
                             NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)};
    [attributedString setAttributes:attrs2 range:NSMakeRange(0, 4)];
    
    currentTextField.attributedText = attributedString;

}


-(void)changeTextStyleToBold{
    
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
    
   
    prevButtonItem.enabled = YES;
    nextButtonItem.enabled = YES;
    
    
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