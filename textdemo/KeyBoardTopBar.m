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
        
        bigTitleButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"大标题" style:UIBarButtonItemStylePlain target:self action:@selector(changeTextToBigTitle)];
        
        smallTitleButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"小标题" style:UIBarButtonItemStylePlain target:self action:@selector(changeTextToSmallTitle)];
        
        orderListButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"有序" style:UIBarButtonItemStylePlain target:self action:@selector(changeTextColorToYellow)];
        
        unorderListButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"无序" style:UIBarButtonItemStylePlain target:self action:@selector(changeTextColorToYellow)];
        
        checkListButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"核查" style:UIBarButtonItemStylePlain target:self action:@selector(changeTextColorToYellow)];
        
        hiddenButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏键盘" style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyBoard)];
        
        spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        view = [[UIToolbar alloc] initWithFrame:CGRectMake(0,-44,420,44)];
        
        view.barStyle = UIBarStyleDefault;
        
        currentTextView = nil;
        
        style = [[NSMutableDictionary alloc] init];
        
    }
    
    return self;
    
}


-(void)changeTextColorToYellow{
    NSString *str = @"bold，little color，hello";

    //NSMutableAttributedString的初始化
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str attributes:attrs];

    //NSMutableAttributedString增加属性
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:36] range:[str rangeOfString:@""]];
    
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
    
    currentTextView.attributedText = attributedString;

}

-(void)changeTextToBigTitle{
    
    if (currentTextView.selectedRange.length==0) {
        [style setValue:[UIFont systemFontOfSize:25] forKey:NSFontAttributeName];
        [self changeTextFontStyle];
        NSLog(@"change big title style:");
    } else {
       
        NSMutableAttributedString *text =[currentTextView.attributedText mutableCopy];
        [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(currentTextView.selectedRange.location, currentTextView.selectedRange.length)];
        
        NSUInteger tmpLocation = currentTextView.selectedRange.location;
        NSUInteger tmpLength = currentTextView.selectedRange.length;
        currentTextView.attributedText = [text copy];
        currentTextView.selectedRange = NSMakeRange(tmpLocation, tmpLength);
        
    }
}


-(void)changeTextToSmallTitle {
    if (currentTextView.selectedRange.length==0) {
        [style setValue:[UIFont systemFontOfSize:20] forKey:NSFontAttributeName];
        [self changeTextFontStyle];
        NSLog(@"change small title style:");
    } else {
        
        NSMutableAttributedString *text =[currentTextView.attributedText mutableCopy];
        [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(currentTextView.selectedRange.location, currentTextView.selectedRange.length)];
        
        NSUInteger tmpLocation = currentTextView.selectedRange.location;
        NSUInteger tmpLength = currentTextView.selectedRange.length;
        currentTextView.attributedText = [text copy];
        currentTextView.selectedRange = NSMakeRange(tmpLocation, tmpLength);
        
    }
}

//显示工具条

-(void)showBar:(UITextView *)textView{
    
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
    
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.3];
    
    view.frame = CGRectMake(0, 420, 420, 44);
    
    [UIView commitAnimations];
    
}

//隐藏键盘和工具条

-(void)hideKeyBoard{
    
    if (currentTextView!=nil) {
        
        [currentTextView  resignFirstResponder];
        
    }
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.3];
    
    view.frame = CGRectMake(0, -44, 420, 44);
    view.barStyle = UIBarStyleDefault;
    [UIView commitAnimations];
    
}

-(void)changeTextFontStyle {
    currentTextView.typingAttributes = style;
    
}

@end