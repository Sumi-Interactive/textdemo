#import <UIKit/UIKit.h>
#import "HPTextViewTapGestureRecognizer/HPTextViewTapGestureRecognizer.h"
#import "OrderList.h"
#import "UnorderList.h"
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
    
    OrderList *orderList;
    UnorderList *unorderList;
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

-(void)dealWithTitle:(int)font;

-(int) getWhichParaCursonIn;

-(int) getParaLocCursonIn;

-(int)getParaTypingMode:(NSRange)range;

-(int)getTypingMode;

-(void)setTypingMode:(int)mode;

-(BOOL)dealWithDelete:(NSRange)range;

-(BOOL)isThisLineEmpty:(NSRange)range;

-(void)editAttributeString:(NSString*)text :(NSRange)range;

-(void)deleteParaIndex;

@end