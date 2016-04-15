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
    //self.textView.keyboardType = UIKeyboardTypeDefault;
    self.textView.delegate=self;
    keyboardbar = [[KeyBoardTopBar alloc]init:self.textView];
    self.tapTextView.delegate = self;
}
- (IBAction)click:(id)sender {
    self.textView.text = @"aiguo";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)textViewDidBeginEditing:(UITextView *)textView{
//    [keyboardbar showBar:textView];//KeyBoardTopBar的实例对象调用显示键盘方法
//}
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

@end
