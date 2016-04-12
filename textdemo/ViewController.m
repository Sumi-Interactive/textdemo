//
//  ViewController.m
//  textdemo
//
//  Created by langker on 16/4/11.
//  Copyright © 2016年 langker. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.layer.borderWidth = 1;
    self.textView.keyboardType = UIKeyboardTypeDefault;
    self.textView.delegate=self;
    
    keyboardbar = [[KeyBoardTopBar alloc]init];
    [self.view addSubview:keyboardbar.view];

    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)click:(id)sender {
    self.textView.text = @"aiguo";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    [keyboardbar showBar:textView];//KeyBoardTopBar的实例对象调用显示键盘方法
}

@end
