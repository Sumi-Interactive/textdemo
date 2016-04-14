//
//  KeyBoardTopBar.m
//  textdemo
//
//  Created by langker on 16/4/11.
//  Copyright © 2016年 langker. All rights reserved.
//

#import "KeyBoardTopBar.h"
#import <YYText/YYText.h>

@implementation KeyBoardTopBar

@synthesize view;


//初始化控件和变量

-(id)init{
    
    if((self = [super init])) {
        
        bigTitleButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"大标题" style:UIBarButtonItemStylePlain target:self action:@selector(changeTextToBigTitle)];
        
        smallTitleButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"小标题" style:UIBarButtonItemStylePlain target:self action:@selector(changeTextToSmallTitle)];
        
        orderListButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"有序" style:UIBarButtonItemStylePlain target:self action:@selector(addOrderList)];
        
        unorderListButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"无序" style:UIBarButtonItemStylePlain target:self action:@selector(addUnorderList)];
        
        checkListButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"核查" style:UIBarButtonItemStylePlain target:self action:@selector(addCheckButton)];
        
        hiddenButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏键盘" style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyBoard)];
        
        spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        view = [[UIToolbar alloc] initWithFrame:CGRectMake(0,-44,420,44)];
        
        view.barStyle = UIBarStyleDefault;
        
        currentTextView = nil;
        
        style = [[NSMutableDictionary alloc] init];
        
    }
    
    return self;
    
}


-(void)addCheckButton {

    NSMutableArray *result = [[currentTextView.text  componentsSeparatedByString:@"\n"] mutableCopy];
    int loc = [self getParaLocCursonIn:result];
    
    CGRect rect = [self frameOfTextRange:NSMakeRange(loc, 0) inTextView:currentTextView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(rect.origin.x, rect.origin.y, 10, 10);
    [btn setTitle:@"R" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(addOrderList) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:rect.origin.y];
    [currentTextView addSubview:btn];
    
    CGRect convertedFrame = [currentTextView convertRect:btn.frame fromView:currentTextView];
    NSMutableArray *l = [[currentTextView textContainer].exclusionPaths mutableCopy];
    [l addObject:[UIBezierPath bezierPathWithRect:convertedFrame]];
    [[currentTextView textContainer] setExclusionPaths:l];
    
    
    
//    
//    NSMutableAttributedString * mutStr = [currentTextView.attributedText mutableCopy];
//    UIImage * image1 = [UIImage imageNamed:@"010"];
//    NSTextAttachment * attachment1 = [[NSTextAttachment alloc] init];
//    attachment1.bounds = CGRectMake(0, 0, 30, 30);
//    attachment1.image = image1;
//    NSAttributedString * attachStr1 = [NSAttributedString attributedStringWithAttachment:attachment1];
//    [mutStr insertAttributedString:attachStr1 atIndex:50];
//    currentTextView.attributedText = [mutStr copy];

}

-(void)changeTextToBigTitle {
    [self dealWithTitle:25];
}


-(void)changeTextToSmallTitle {
    [self dealWithTitle:20];
}

-(void)addOrderList {
    NSLog(@"memeda1");
}

-(void)addUnorderList {
    NSMutableArray *result = [[currentTextView.text  componentsSeparatedByString:@"\n"] mutableCopy];
   
    int row = [self getWhichParaCursonIn:result];
   
    result[row]= [NSString stringWithFormat:@"- %@",result[row]];
    
    currentTextView.text = [result componentsJoinedByString:@"\n"];

}

//显示工具条

-(void)showBar:(UITextView *)textView {
    
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

-(void)hideKeyBoard {
    
    if (currentTextView!=nil) {
        
        [currentTextView  resignFirstResponder];
        
    }
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.3];
    
    view.frame = CGRectMake(0, -44, 420, 44);
    view.barStyle = UIBarStyleDefault;
    [UIView commitAnimations];
    
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

- (CGRect)frameOfTextRange:(NSRange)range inTextView:(UITextView *)textView
{
    UITextPosition *beginning = textView.beginningOfDocument;
    UITextPosition *start = [textView positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [textView positionFromPosition:start offset:range.length];
    UITextRange *textRange = [textView textRangeFromPosition:start toPosition:end];
    CGRect rect = [textView firstRectForRange:textRange];
    return [textView convertRect:rect fromView:textView.textInputView];
}

-(void)deleteCheckButton {
    CGRect cursor = [self frameOfTextRange:NSMakeRange(currentTextView.selectedRange.location, 0) inTextView:currentTextView];
    
    NSMutableArray *result = [[currentTextView.text  componentsSeparatedByString:@"\n"] mutableCopy];
    int loc = [self getParaLocCursonIn:result];
    CGRect paraIndex = [self frameOfTextRange:NSMakeRange(loc, 0) inTextView:currentTextView];
    if (cursor.origin.x<35 && cursor.origin.y==paraIndex.origin.y ){
        for (UIView *subviews in [currentTextView subviews]) {
            if (subviews.tag==paraIndex.origin.y) {
                NSMutableArray *l = [[currentTextView textContainer].exclusionPaths mutableCopy];
                CGRect btnRect = subviews.frame;
                [l removeObject:[UIBezierPath bezierPathWithRect:btnRect]];
                [[currentTextView textContainer] setExclusionPaths:l];
                [subviews removeFromSuperview];
            }
        }
    }
}

-(int) getWhichParaCursonIn:(NSMutableArray *)result {
    int count = (int)result.count;
    int loc = (int)currentTextView.selectedRange.location;
    int row = 0;
    NSMutableArray *offset = [[NSMutableArray alloc] init];
    for (int i=0,foo=0; i<count; i++) {
        [offset addObject:[NSNumber numberWithInt:foo]];
        foo = foo + (int)[result[i] length] + 1;
        if (count-1==i)
            [offset addObject:[NSNumber numberWithInt:foo]];
    }
    
    for (int i=0; i<count; i++) {
        
        if ( loc>=[offset[i] intValue]&&loc<[offset[i+1] intValue]) {
            row = i;
            break;
        }
    }
    return row;
}

-(int) getParaLocCursonIn:(NSMutableArray *)result {
    int count = (int)result.count;
    int loc = (int)currentTextView.selectedRange.location;
    int row = 0;
    NSMutableArray *offset = [[NSMutableArray alloc] init];
    for (int i=0,foo=0; i<count; i++) {
        [offset addObject:[NSNumber numberWithInt:foo]];
        foo = foo + (int)[result[i] length] + 1;
        if (count-1==i)
            [offset addObject:[NSNumber numberWithInt:foo]];
    }
    
    for (int i=0; i<count; i++) {
        
        if ( loc>=[offset[i] intValue]&&loc<[offset[i+1] intValue]) {
            row = [offset[i] intValue];
            break;
        }
    }
    return row;
}


@end