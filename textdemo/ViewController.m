//
//  ViewController.m
//  textdemo
//
//  Created by langker on 16/4/11.
//  Copyright © 2016年 langker. All rights reserved.
//

#import "ViewController.h"
#import "HPTextViewTapGestureRecognizer/HPTextViewTapGestureRecognizer.h"

@interface ViewController () <UITextViewDelegate,UITextFieldDelegate,HPTextViewTapGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet HPTextViewTapGestureRecognizer *tapTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.layer.borderWidth = 1;
    self.textView.allowsEditingTextAttributes = TRUE;
    self.textView.delegate=self;
    keyboardbar = [[KeyBoardTopBar alloc]init:self.textView];
    self.tapTextView.delegate = self;
    
    //注册通知,监听键盘出现
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidShow:)
                                                name:UIKeyboardDidShowNotification
                                              object:nil];
    //注册通知，监听键盘消失事件
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidHidden)
                                                name:UIKeyboardDidHideNotification
                                              object:nil];
}

//监听事件
- (void)handleKeyboardDidShow:(NSNotification*)paramNotification
{
    //获取键盘高度
    NSValue *keyboardRectAsObject=[[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    [keyboardRectAsObject getValue:&keyboardRect];
    
    self.textView.contentInset=UIEdgeInsetsMake(0, 0,keyboardRect.size.height, 0);
}

- (void)handleKeyboardDidHidden
{
    self.textView.contentInset=UIEdgeInsetsZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer handleTapOnTextAttachment:(NSTextAttachment*)textAttachment inRange:(NSRange)characterRange
{
    NSMutableAttributedString * mutStr = [self.textView.attributedText mutableCopy];
    [mutStr deleteCharactersInRange:characterRange];
    NSTextAttachment * attachment = [[NSTextAttachment alloc] init];
    attachment.bounds = CGRectMake(0, 0, 30, 30);
    if ([textAttachment.image.accessibilityIdentifier isEqualToString: @"unchecked"])  {
        attachment.image = [UIImage imageNamed:@"011"];
        [attachment.image setAccessibilityIdentifier:@"checked"];
        NSAttributedString * attachStr = [NSAttributedString attributedStringWithAttachment:attachment];
        
        [mutStr insertAttributedString:attachStr atIndex:characterRange.location];
        self.textView.attributedText = [mutStr copy];
    } else if ([textAttachment.image.accessibilityIdentifier isEqualToString:@"checked"]) {
        attachment.image = [UIImage imageNamed:@"010"];
        [attachment.image setAccessibilityIdentifier:@"unchecked"];
        NSAttributedString * attachStr = [NSAttributedString attributedStringWithAttachment:attachment];
        
        [mutStr insertAttributedString:attachStr atIndex:characterRange.location];
        self.textView.attributedText = [mutStr copy];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [self.textView insertText:@"\n"];
        [keyboardbar addOrderList];
    }
    
    return NO;
}

@end
