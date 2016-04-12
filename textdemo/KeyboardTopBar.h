#import <UIKit/UIKit.h>


@interface KeyBoardTopBar : NSObject {
    
    UIToolbar       *view;                       //工具条
    
    NSArray         *textFields;                 //输入框数组
    
    UIBarButtonItem *bigTitleButtonItem;             //上一项按钮
    
    UIBarButtonItem *smallTitleButtonItem;             //下一项按钮
    
    UIBarButtonItem *hiddenButtonItem;           //隐藏按钮
    
    UIBarButtonItem *spaceButtonItem;            //空白按钮
    
    UITextView     *currentTextView;           //当前输入框
    
}

@property(nonatomic,retain) UIToolbar *view;


-(id)init;

-(void)setTextFieldsArray:(NSArray *)array;

-(void)changeTextColorToYellow;

-(void)changeTextStyleToBold;

-(void)showBar:(UITextView *)textView;

-(void)HiddenKeyBoard;

@end