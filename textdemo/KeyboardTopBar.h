#import <UIKit/UIKit.h>


@interface KeyBoardTopBar : NSObject {
    
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


-(id)init;

-(void)addCheckButton;

-(void)changeTextToBigTitle;

-(void)changeTextToSmallTitle;

-(void)addUnorderList;

-(void)addOrderList;

-(void)showBar:(UITextView *)textView;

-(void)hideKeyBoard;

-(void)changeTextFontStyle;

-(void) dealWithTitle:(int)font;

-(CGRect)frameOfTextRange:(NSRange)range inTextView:(UITextView *)textView;

-(void)deleteCheckButton;

-(int) getWhichParaCursonIn:(NSMutableArray *)result;

-(int) getParaLocCursonIn:(NSMutableArray *)result;

@end