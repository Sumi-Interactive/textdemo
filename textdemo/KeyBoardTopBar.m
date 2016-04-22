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

-(id)init:(UITextView *)textView{
    
    if((self = [super init])) {
        
        bigTitleButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"大标题" style:UIBarButtonItemStylePlain target:self action:@selector(changeTextToBigTitle)];
        
        smallTitleButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"小标题" style:UIBarButtonItemStylePlain target:self action:@selector(changeTextToSmallTitle)];
        
        orderListButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"有序" style:UIBarButtonItemStylePlain target:self action:@selector(addOrderList)];
        
        unorderListButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"无序" style:UIBarButtonItemStylePlain target:self action:@selector(addUnorderList)];
        
        checkListButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"核查" style:UIBarButtonItemStylePlain target:self action:@selector(addCheckButton)];
        
        hiddenButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏键盘" style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyBoard)];
        
        spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        view = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,400,44)];
        
        view.barStyle = UIBarStyleDefault;
        
        style = [[NSMutableDictionary alloc] init];
        
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
        
        currentTextView.inputAccessoryView = view;
        
        orderList = [[OrderList alloc] init:currentTextView];
        unorderList = [[UnorderList alloc] init:currentTextView];
        checkList = [[CheckList alloc] init:currentTextView];
        
        typingMode = NONESTYLE;
        
    }
    
    return self;
    
}

-(void)addOrderList {
    [orderList addOrderList];
    typingMode = ORDERLIST;
}

-(void)addUnorderList {
    [unorderList addUnorderList];
    typingMode = UNORDERLIST;
}
-(void)addCheckButton {
    [checkList addCheckList];
    typingMode = CHECKLIST;
}

-(void)changeTextToBigTitle {
    [self dealWithTitle:30];
}


-(void)changeTextToSmallTitle {
    [self dealWithTitle:25];
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

-(void)hideKeyBoard {
    
    if (currentTextView!=nil) {
        
        [currentTextView  resignFirstResponder];
        
    }
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.3];
    
    view.barStyle = UIBarStyleDefault;
    [UIView commitAnimations];
    
}

-(int) getWhichParaCursonIn {
    NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
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

-(int) getParaLocCursonIn {
     NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
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

-(int)getParaTypingMode:(NSRange)range {
    NSMutableArray *result = [[currentTextView.attributedText.string componentsSeparatedByString:@"\n"] mutableCopy];
    int loc = [self getParaLocCursonIn];
    int row = [self getWhichParaCursonIn];
    if (range.location==currentTextView.attributedText.string.length) {
        return typingMode;
      }
    NSString *isUnorderList;
    if ([result[row] length]>=2) {
        isUnorderList = [result[row] substringWithRange:NSMakeRange(0,2)];
    } else {
        isUnorderList = [[NSString alloc ]init];
    }
    NSString *isOrderList = [result[row] componentsSeparatedByString:@"."][0];
    NSMutableAttributedString *mutStr = [currentTextView.attributedText copy];
    if ([isUnorderList isEqualToString:@"- "]) {
        typingMode = UNORDERLIST;
        return UNORDERLIST;
    } else if([isOrderList intValue]!=0) {
        typingMode = ORDERLIST;
        return ORDERLIST;
    } else if([mutStr containsAttachmentsInRange:NSMakeRange(loc,1)]==TRUE) {
        typingMode = CHECKLIST;
        return CHECKLIST;
    } else {
        typingMode = NONESTYLE;
        return NONESTYLE;
    }
}

-(int)getTypingMode {
    return typingMode;
}

-(void)setTypingMode:(int)mode {
    typingMode = mode;
}

-(BOOL)dealWithDelete:(NSRange)range {
    switch([self getTypingMode]) {
        case UNORDERLIST:
            return [unorderList dealWithDelete:range];
        case ORDERLIST:
            return [orderList dealWithDelete:range];
        case CHECKLIST:
            return [checkList dealWithDelete:range];
        default:
            return TRUE;
    }
}

-(BOOL)isThisLineEmpty:(NSRange)range {
    switch([self getTypingMode]) {
        case ORDERLIST:
            return [orderList isThisLineEmpty:range];
        case UNORDERLIST:
            return [unorderList isThisLineEmpty:range];
        case CHECKLIST:
            return [checkList isThisLineEmpty:range];
        default:
            return FALSE;
    }
}

@end