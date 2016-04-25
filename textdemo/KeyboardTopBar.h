#import <UIKit/UIKit.h>
#import "HPTextViewTapGestureRecognizer/HPTextViewTapGestureRecognizer.h"
#import "ListController.h"

@interface KeyBoardTopBar : UIViewController<HPTextViewTapGestureRecognizerDelegate> {
    
    UIToolbar       *view;
    
    UIBarButtonItem *bigTitleButtonItem;
    
    UIBarButtonItem *smallTitleButtonItem;
    
    UIBarButtonItem *orderListButtonItem;
    
    UIBarButtonItem *unorderListButtonItem;

    UIBarButtonItem *checkListButtonItem;
    
    UIBarButtonItem *hiddenButtonItem;
    
    UIBarButtonItem *spaceButtonItem;
    
    NSMutableDictionary *style;
    
    UITextView *currentTextView;
    
    ListController *list;
}

@property(nonatomic,retain) UIToolbar *view;
@property(nonatomic,retain) ListController *list;


-(id)init:(UITextView *)textView;

-(void)addCheckButton;

-(void)addUnorderList;

-(void)addOrderList;

-(void)changeTextToBigTitle;

-(void)changeTextToSmallTitle;

-(void)hideKeyBoard;

-(void)changeTextFontStyle;

-(void)dealWithTitle:(int)font;

@end