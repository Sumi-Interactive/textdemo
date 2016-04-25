#import <UIKit/UIKit.h>
#import "HPTextViewTapGestureRecognizer/HPTextViewTapGestureRecognizer.h"
#import "ListController.h"
#import "StyleController.h"

@interface KeyBoardTopBar : UIViewController<HPTextViewTapGestureRecognizerDelegate> {
    
    UIToolbar       *view;
    
    UIBarButtonItem *bigTitleButtonItem;
    
    UIBarButtonItem *smallTitleButtonItem;
    
    UIBarButtonItem *orderListButtonItem;
    
    UIBarButtonItem *unorderListButtonItem;

    UIBarButtonItem *checkListButtonItem;
    
    UIBarButtonItem *hiddenButtonItem;
    
    UIBarButtonItem *spaceButtonItem;
    
    UITextView *currentTextView;
    
    ListController *list;
    
    StyleController *style;
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

@end