//
//  ViewController.m
//  YYAtPersonDemo
//
//  Created by Ace on 2017/9/8.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "YYViewController.h"
#import "YYPersonListViewController.h"
#import "UITextView+Placeholder.h"
#import "UIView+Tools.h"
#import "YYToolbar.h"
#import "Defines.h"
#import "YYPersonItem.h"
#import "YYTextAttachmentManager.h"
#import "NSAttributedString+YY.h"


@interface YYViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView * textView;

@property (nonatomic, strong) YYToolbar * toolbar;
@property (nonatomic, assign) BOOL needBack;

@property (nonatomic, strong) NSMutableArray * currentSelectedPersonItems;

@end

@implementation YYViewController

#pragma mark -
#pragma mark getter setter

- (YYToolbar *)toolbar {
    if (!_toolbar) {
        __weak typeof(self) weakSelf = self;
        _toolbar = [[YYToolbar alloc] initWithFrame:CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44)];
        _toolbar.atButtonPressedBlock = ^(id userInfo) {
            [weakSelf yy_toolbarAtButtonPressed];
        };
    }
    return _toolbar;
}


#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //iOS7之后，使用UINavigationController使UIScrollView内容居中显示了,下面代码可以使其居上显示
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.textView.placeholder = @"@人示例...";
    self.textView.delegate = self;
    
    [self.view addSubview:self.toolbar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.textView becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark -
#pragma mark Keyboard Notifications

- (void)keyboardWillShow:(NSNotification *)notification {
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        return;
    }
    UIViewAnimationOptions animationCurve	= [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect endFrame = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect newFrame = self.toolbar.frame;
    newFrame.size.height = self.toolbar.height;
    newFrame.origin.y = self.view.height - newFrame.size.height - endFrame.size.height;
    
    [UIView animateWithDuration:animationDuration delay:0 options:(animationCurve << 16) animations:^{
        self.toolbar.frame = newFrame;
    }completion:^(BOOL finished) {
        
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        return;
    }
    
    UIViewAnimationOptions animationCurve	= [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:animationDuration delay:0 options:(animationCurve << 16) animations:^{
        self.toolbar.top  = self.view.bottom - self.toolbar.height;
    }completion:^(BOOL finished) {
        
    }];
}

#pragma mark -
#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text  {
    
    // Insert @ and mention.
    if ([text isEqualToString:@"@"]) {
        
        if (range.length > 0) {
            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:text];
            [self.textView.textStorage replaceCharactersInRange:range withAttributedString:attributedString];
        }
        
        self.needBack = YES; //需要将手动输入的@删除
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf presentPersonListViewController];
        });
        return YES;
    }
    
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView {
    self.currentSelectedPersonItems = [NSMutableArray arrayWithArray:[self.textView.attributedText getCurrentAtPersonItems]];
}


#pragma mark -
#pragma mark Private method

- (void)yy_toolbarAtButtonPressed {
    self.needBack = NO;
    [self presentPersonListViewController];
}

- (void)presentPersonListViewController {
    __weak typeof(self) weakSelf = self;
    YYPersonListViewController *vc = [[YYPersonListViewController alloc] init];
    vc.cancelSelectedBolck = ^(id userInfo) {
        [weakSelf textViewDidChange:self.textView];
    };
    vc.finishSelectedBlock = ^(YYPersonItem *personItem) {
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:self.textView.font.pointSize]};
        NSMutableArray *currentSelectedPersonItems = [[self.textView.attributedText getCurrentAtPersonItems] mutableCopy];
        [currentSelectedPersonItems addObject:personItem];//这里可以判断去重...（根据自己需求情况而定）
        
        //将人的名字转化为NSTextAttachment
        [[YYTextAttachmentManager getInstance] transformTextWithTextView:self.textView tickedPersonItems:currentSelectedPersonItems atAllPersons:nil canRepeat:NO needBack:self.needBack color:[UIColor colorWithRed:0.271 green:0.435 blue:0.451 alpha:1.000] attributes:attributes completeBlock:^(NSMutableAttributedString *mutableAttributedString, NSRange selectedRange) {
            weakSelf.needBack = NO;
            weakSelf.textView.attributedText = mutableAttributedString;
            weakSelf.textView.selectedRange = selectedRange;
            [weakSelf textViewDidChange:weakSelf.textView];
        }];
    };
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
}



@end
