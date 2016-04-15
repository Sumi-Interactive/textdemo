#import <UIKit/UIKit.h>
#import "HPTextViewTapGestureRecognizer/HPTextViewTapGestureRecognizer.h"

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

-(CGRect)frameOfTextRange:(NSRange)range inTextView:(UITextView *)textView;

-(void)deleteCheckButton;

-(int) getWhichParaCursonIn:(NSMutableArray *)result;

-(int) getParaLocCursonIn:(NSMutableArray *)result;

@end