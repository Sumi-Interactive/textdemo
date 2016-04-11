//
//  ViewController.m
//  textdemo
//
//  Created by langker on 16/4/11.
//  Copyright © 2016年 langker. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.layer.borderWidth = 1;
    self.textView.keyboardType = UIKeyboardTypeDefault;
    self.textView.delegate=self;
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)click:(id)sender {
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
    
    self.label.attributedText = attributedString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
