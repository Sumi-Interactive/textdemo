
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
    
    rangeWhenClickCheck.location = -1;
    
    self.textView.layer.borderWidth = 1;
    self.textView.allowsEditingTextAttributes = TRUE;
    self.textView.editable = YES;
    self.textView.delegate = self;
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
    rangeWhenClickCheck = self.textView.selectedRange;
    NSMutableAttributedString * mutStr = [self.textView.attributedText mutableCopy];
    [mutStr deleteCharactersInRange:characterRange];
    NSTextAttachment * attachment = [[NSTextAttachment alloc] init];
    attachment.bounds = CGRectMake(0, 0, 30, 30);
    
    if ([textAttachment.image.accessibilityIdentifier isEqualToString: @"unchecked"])  {
        attachment.image = [UIImage imageNamed:@"icon-checkbox-checked"];
        [attachment.image setAccessibilityIdentifier:@"checked"];
        NSAttributedString * attachStr = [NSAttributedString attributedStringWithAttachment:attachment];
        
        [mutStr insertAttributedString:attachStr atIndex:characterRange.location];
        self.textView.attributedText = [mutStr copy];
    } else if ([textAttachment.image.accessibilityIdentifier isEqualToString:@"checked"]) {
        attachment.image = [UIImage imageNamed:@"icon-checkbox-normal"];
        [attachment.image setAccessibilityIdentifier:@"unchecked"];
        NSAttributedString * attachStr = [NSAttributedString attributedStringWithAttachment:attachment];
        
        [mutStr insertAttributedString:attachStr atIndex:characterRange.location];
        self.textView.attributedText = [mutStr copy];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    [keyboardbar.list changeTypingMode];
    if ([text isEqualToString:@"\n"]) {
        if ([keyboardbar.list isThisLineEmpty:range]) {
            [keyboardbar.list deleteParaIndex];
            return YES;
        } else {
            [self.textView insertText:@"\n"];
            switch([keyboardbar.list getTypingMode]) {
                case ORDERLIST:
                    [keyboardbar addOrderList];
                    break;
                case UNORDERLIST:
                    [keyboardbar addUnorderList];
                    break;
                case CHECKLIST:
                    [keyboardbar addCheckButton];
                    break;
            }
            return NO;
        }
    } else if ([text length] == 0) {
        if ([keyboardbar.list isThisLineEmpty:NSMakeRange(range.location+1, range.length)]) {
            [keyboardbar.list dealWithDelete:NSMakeRange(range.location+1, range.length)];
            return NO;
        }
    }
    
    return YES;
}
- (void)textViewDidChangeSelection:(UITextView *)tve {
    if (rangeWhenClickCheck.location!=-1) {
        tve.selectedRange = rangeWhenClickCheck;
        rangeWhenClickCheck.location = -1;
    }
}

#pragma mark - Button Actions

- (IBAction)alertTextButtonAction:(id)sender {
    NSAttributedString *text = self.textView.attributedText;
    
    NSLog(@"%@", text);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"text content" message:text preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
