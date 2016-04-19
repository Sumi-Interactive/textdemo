#import <UIKit/UIKit.h>
#import "HPTextViewTapGestureRecognizer/HPTextViewTapGestureRecognizer.h"

const int NONESTYLE = 0;
const int CHECKLIST = 1;
const int ORDERLIST = 2;
const int UNORDERLIST = 3;


@interface KeyBoardTopBar : UIViewController<HPTextViewTapGestureRecognizerDelegate> {
    
    UIToolbar       *view;
    
    UIBarButtonItem *bigTitleButtonItem;
    
    UIBarButtonItem *smallTitleButtonItem;
    
    UIBarButtonItem *orderListButtonItem;
    
    UIBarButtonItem *unorderListButtonItem;

    UIBarButtonItem *checkListButtonItem;
    
    UIBarButtonItem *hiddenButtonItem;
    
    UIBarButtonItem *spaceButtonItem;
    
    UITextView     *currentTextView;
    
    NSMutableDictionary *style;
    
    int typingMode;
}

@property(nonatomic,retain) UIToolbar *view;


-(id)init:(UITextView *)textView;

-(void)addCheckButton;

-(void)changeTextToBigTitle;

-(void)changeTextToSmallTitle;

-(void)addUnorderList;

-(void)addOrderList;

-(void)hideKeyBoard;

-(void)changeTextFontStyle;

-(void) dealWithTitle:(int)font;

-(int) getWhichParaCursonIn:(NSMutableArray *)result;

-(int) getParaLocCursonIn:(NSMutableArray *)result;

-(int)getTypingMode;

-(void)setTypingMode:(int)mode;

-(BOOL)dealWithDelete:(NSRange)range;

-(BOOL)isThisLineEmpty:(NSRange)range;

@end