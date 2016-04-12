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
    
}

@property(nonatomic,retain) UIToolbar *view;


-(id)init;

-(void)changeTextColorToYellow;

-(void)changeTextStyleToBold;

-(void)showBar:(UITextView *)textView;

-(void)HiddenKeyBoard;

@end