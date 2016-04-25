//
//  StyleController.h
//  textdemo
//
//  Created by langker on 16/4/25.
//  Copyright © 2016年 langker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface StyleController : NSObject {
    NSMutableDictionary *style;
    UITextView *currentTextView;
}

-(id)init:(UITextView *)textView;

-(void)setTextSize:(int)textSize;

-(void)resetTextStyle;

@end

