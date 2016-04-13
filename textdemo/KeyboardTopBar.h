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

-(void)changeTextColorToYellow;

-(void)changeTextToBigTitle;

-(void)changeTextToSmallTitle;

-(void)showBar:(UITextView *)textView;

-(void)hideKeyBoard;

-(void)changeTextFontStyle;

@end