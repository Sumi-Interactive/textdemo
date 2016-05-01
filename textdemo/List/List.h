//
//  List.h
//  textdemo
//
//  Created by langker on 16/4/22.
//  Copyright © 2016年 langker. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface List : NSObject {
    UITextView     *currentTextView;
}

-(int)getWhichParaCursonIn;

-(int)getParaLocCursonIn;

-(void)editAttributeString:(NSString*)text :(NSRange)range;

-(id)init:(UITextView *)textView;

@end