//
//  CheckList.h
//  textdemo
//
//  Created by langker on 16/4/22.
//  Copyright © 2016年 langker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "List.h"
@interface CheckList : List {
    
}

-(void)dealWithDelete:(NSRange)range;

-(BOOL)isThisLineEmpty:(NSRange)range;

-(void)addCheckList;

-(void)deleteParaIndex;

-(BOOL)isParaContainIndex:(NSRange)range;

@end
