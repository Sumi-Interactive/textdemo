#import <UIKit/UIKit.h>
#import "HPTextViewTapGestureRecognizer/HPTextViewTapGestureRecognizer.h"

typedef NS_ENUM(NSInteger,typingType){
    NONESTYLE = 0,
    CHECKLIST = 1,
    ORDERLIST = 2,
    UNORDERLIST = 3
};



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

-(void)editAttributeString:(NSString*)text :(NSRange)range; 

@end