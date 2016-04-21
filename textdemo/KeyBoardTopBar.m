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
        
        typingMode = NONESTYLE;
        
    }
    
    return self;
    
}


-(void)addCheckButton {
    [self deleteParaIndex];
    NSMutableAttributedString * mutStr = [currentTextView.attributedText mutableCopy];
    NSTextAttachment * attachment = [[NSTextAttachment alloc] init];
    attachment.bounds = CGRectMake(0, 0, 30, 30);
    attachment.image = [UIImage imageNamed:@"010"];
    [attachment.image setAccessibilityIdentifier:@"unchecked"];
    NSAttributedString * attachStr = [NSAttributedString attributedStringWithAttachment:attachment];
    
    int loc = [self getParaLocCursonIn:[[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy] ];
    [mutStr insertAttributedString:attachStr atIndex:loc];
    currentTextView.attributedText = [mutStr copy];
    
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

-(void)addOrderList {
    [self deleteParaIndex];
    NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
    
    int row = [self getWhichParaCursonIn:result];
    int loc = [self getParaLocCursonIn:result];
    
    int i = 1 ;
    
    if (row!=0) {
        int number = [result[row-1] componentsSeparatedByString:@"."][0].intValue;
        if (number==0) {
            i = 1;
        } else {
            i = number+1;
        }
    }
    
    NSString *replace = [NSString stringWithFormat:@"%d. %@",i,result[row]];
    [self editAttributeString:replace :NSMakeRange(loc, [result[row] length])];
    
    for(int j=row+1;j<result.count;j++) {
        int tmp = [result[j] componentsSeparatedByString:@"."][0].intValue;
        if (tmp!=0){
            NSRange range = [currentTextView.attributedText.string rangeOfString:result[j]];
            NSMutableAttributedString *replace = [currentTextView.attributedText mutableCopy];
            NSMutableString *text = [NSMutableString stringWithString:result[j]];
            NSString *newIndexLength = [NSString stringWithFormat:@"%d .",tmp];
            NSString *newIndex = [NSString stringWithFormat:@"%d. ",tmp+1];
            [text replaceCharactersInRange:NSMakeRange(0, newIndexLength.length) withString:newIndex];

            [replace.mutableString replaceCharactersInRange:range withString:text];
            currentTextView.attributedText  = [replace copy];
        } else {
            break;
        }
    }
    
    typingMode = ORDERLIST;
}

-(void)addUnorderList {
    [self deleteParaIndex];
    NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
    
    int row = [self getWhichParaCursonIn:result];
    int loc = [self getParaLocCursonIn:result];
    
    NSString *replace = [NSString stringWithFormat:@"- %@",result[row]];
    
    [self editAttributeString:replace :NSMakeRange(loc, [result[row] length]) ];
    typingMode = UNORDERLIST;

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

-(int)getParaTypingMode:(NSRange)range {
    NSMutableArray *result = [[currentTextView.attributedText.string componentsSeparatedByString:@"\n"] mutableCopy];
    int loc = [self getParaLocCursonIn:result];
    int row = [self getWhichParaCursonIn:result];
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
    if (range.location!=0) {
        switch([self getTypingMode]) {
            case UNORDERLIST:
            {
                NSAttributedString *firstCharOfPara = [currentTextView.attributedText attributedSubstringFromRange:NSMakeRange(range.location-1,2)];
                if ([firstCharOfPara.string isEqualToString:@"- "]) {
                    NSMutableAttributedString * mutStr = [currentTextView.attributedText mutableCopy];
                    [mutStr deleteCharactersInRange:NSMakeRange(range.location-1,2)];
                    currentTextView.attributedText = [mutStr copy];
                    return FALSE;
                }
            }
            case ORDERLIST:
            {
                NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
            
                int row = [self getWhichParaCursonIn:result];
                int locOfPara = [self getParaLocCursonIn:result];
                int locOfIndex= (int)[result[row] componentsSeparatedByString:@"."][0].length+1;
                if (locOfPara+locOfIndex==range.location) {
                    NSMutableAttributedString * mutStr = [currentTextView.attributedText mutableCopy];
                    if (locOfPara!=0)
                        [mutStr deleteCharactersInRange:NSMakeRange(locOfPara-1,locOfIndex+1)];
                    else
                        [mutStr deleteCharactersInRange:NSMakeRange(locOfPara,locOfIndex+1)];
                    currentTextView.attributedText = [mutStr copy];
                
                    for(int j=row+1;j<result.count;j++) {
                        int tmp = [result[j] componentsSeparatedByString:@"."][0].intValue;
                        if (tmp!=0){
                            NSRange range = [currentTextView.attributedText.string rangeOfString:result[j]];
                            NSMutableAttributedString *replace = [currentTextView.attributedText mutableCopy];
                            NSMutableString *text = [NSMutableString stringWithString:result[j]];
                            NSString *newIndexLength = [NSString stringWithFormat:@"%d .",tmp];
                            NSString *newIndex = [NSString stringWithFormat:@"%d. ",tmp-1];
                            [text replaceCharactersInRange:NSMakeRange(0, newIndexLength.length) withString:newIndex];
                        
                            [replace.mutableString replaceCharactersInRange:range withString:text];
                            currentTextView.attributedText  = [replace copy];
                        } else {
                            break;
                        }
                    }
                
                    return FALSE;
                }
            }
            case CHECKLIST:
            {
                //TODO:edit
                NSMutableAttributedString *mutStr = [currentTextView.attributedText copy];
                if([mutStr containsAttachmentsInRange:NSMakeRange(range.location,1)]==TRUE) {
                    NSMutableAttributedString * mutStr = [currentTextView.attributedText mutableCopy];
                    [mutStr deleteCharactersInRange:NSMakeRange(range.location,1)];
                    currentTextView.attributedText = [mutStr copy];
                    return FALSE;
                }
            }
        }
    }
    return TRUE;
}

-(BOOL)isThisLineEmpty:(NSRange)range {
    
    NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
   
    int row = [self getWhichParaCursonIn:[result mutableCopy]];
    if ([result[row] length]==0)
        return FALSE;
    
    int loc = [self getParaLocCursonIn:[result mutableCopy]];
    switch([self getTypingMode]) {
        case ORDERLIST:
        {
            NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
            
            int row = [self getWhichParaCursonIn:result];
            int number = (int)[result[row] componentsSeparatedByString:@"."][0].intValue;
            int locOfIndex= (int)[result[row] componentsSeparatedByString:@"."][0].length+1;
            if (number!=0) {
                if (loc+locOfIndex+1==range.location) {
                    return TRUE;
                } else {
                    return FALSE;
                }
            }
        }
        case CHECKLIST:
        {
            NSMutableAttributedString *mutStr = [currentTextView.attributedText copy];
            if([mutStr containsAttachmentsInRange:NSMakeRange(loc,1)]==TRUE) {
                if (range.location==loc+1) {
                    return TRUE;
                } else {
                    return FALSE;
                }
            }
        }
        case UNORDERLIST:
        {
            NSAttributedString *firstCharOfPara = [currentTextView.attributedText attributedSubstringFromRange:NSMakeRange(loc,2)];
            if ([firstCharOfPara.string isEqualToString:@"- "]) {
                if (loc+2==range.location) {
                    return TRUE;
                } else {
                    return FALSE;
                }
            }
        }
    }
    return FALSE;
}

-(void)editAttributeString:(NSString*)text :(NSRange)range{
    NSMutableAttributedString *replace = [currentTextView.attributedText mutableCopy];
    [replace.mutableString replaceCharactersInRange:range withString:text];
    currentTextView.attributedText  = [replace copy];
}

-(void)deleteParaIndex {
    NSRange range = currentTextView.selectedRange;
    if([self isParaContainIndex:currentTextView.selectedRange]==FALSE) return;
    switch([self getParaTypingMode:currentTextView.selectedRange]){
        case UNORDERLIST:
        {
            NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
            int loc = [self getParaLocCursonIn:result];
            NSMutableAttributedString * mutStr = [currentTextView.attributedText mutableCopy];
            [mutStr deleteCharactersInRange:NSMakeRange(loc,2)];
            currentTextView.attributedText = [mutStr copy];
            range.location-=2;
            currentTextView.selectedRange = range;
            break;
        }
        case ORDERLIST:
        {
            NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
            int row = [self getWhichParaCursonIn:result];
            int loc = [self getParaLocCursonIn:result];
            int locOfIndex= (int)[result[row] componentsSeparatedByString:@"."][0].length+1;
            
            NSMutableAttributedString * mutStr = [currentTextView.attributedText mutableCopy];
            [mutStr deleteCharactersInRange:NSMakeRange(loc,locOfIndex+1)];
            currentTextView.attributedText = [mutStr copy];
            range.location = range.location - locOfIndex-1;
            currentTextView.selectedRange = range;
            break;
        }
        case CHECKLIST:
        {
            NSMutableArray *result = [[currentTextView.attributedText.string  componentsSeparatedByString:@"\n"] mutableCopy];
            int loc = [self getParaLocCursonIn:result];
            NSMutableAttributedString * mutStr = [currentTextView.attributedText mutableCopy];
            [mutStr deleteCharactersInRange:NSMakeRange(loc,1)];
            currentTextView.attributedText = [mutStr copy];
            
            break;
        }
    }
}

-(BOOL)isParaContainIndex:(NSRange)range {
    NSMutableArray *result = [[currentTextView.attributedText.string componentsSeparatedByString:@"\n"] mutableCopy];
    int row = [self getWhichParaCursonIn:result];
    int loc = [self getParaLocCursonIn:result];
    NSMutableAttributedString *str = [currentTextView.attributedText mutableCopy];
    if ([result[row] componentsSeparatedByString:@"."][0].intValue!=0) {
        return TRUE;
    } else if([result[row] length]>=2 && [[result[row] substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"- "]) {
        return TRUE;
    } else if(loc+1<=str.length &&[str containsAttachmentsInRange:NSMakeRange(loc, 1)]==TRUE) {
        return TRUE;
    } else {
        return FALSE;
    }
}

@end