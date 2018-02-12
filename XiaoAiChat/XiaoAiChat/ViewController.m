//
//  ViewController.m
//  XiaoAiChat
//  tuling123.com  aysfwyg@163.com  Wyg741564552
//  Created by wangyaoguo on 2018/2/11.
//  Copyright © 2018年 lianluo.com. All rights reserved.
//
#import "ViewController.h"
#import "TextSelfTableViewCell.h"

#define BUNDLEID           @"com.xiaoaichatmachine"
#define BAIDU_API_ID       @"10822787"
#define BAIDU_APP_KEY      @"DW6gKKy3ZCbX64w2TX5pcYS6"
#define BAIDU_SECERT_KEY   @"36e14e1a245f2e683804e08dd7763204"
#define TULING_API_ADDRESS @"http://www.tuling123.com/openapi/api"
#define TULING_API_KEY     @"feb2934f92134e26adcae578f26e543c"
#define SCREEN_WIDTH       [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT      [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"聊天机器人";
    
    _keyInput.delegate = self;
    _keyInput.returnKeyType = UIReturnKeySend;
    _keyView.frame = CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45);
    _keyInput.frame = CGRectMake(30, 7, SCREEN_WIDTH - 60, 30);

    [_chatTableView registerNib:[UINib nibWithNibName:@"TextSelfTableViewCell" bundle:nil] forCellReuseIdentifier:@"selfchatcell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapKeyBoardDown)];
    [self.view addGestureRecognizer:tap];
}
    
-(void)calDialogHeight:(NSString *)text {
    int maxWidth = SCREEN_WIDTH - 105;
    
}

-(void)keyBoardShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    self.keyView.frame = CGRectMake(0, SCREEN_HEIGHT - height - 45, SCREEN_WIDTH, 45);
}

-(void)keyBoardHide:(NSNotification *)notification {
    _keyView.frame = CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45);
}
    
-(void)tapKeyBoardDown {
    [_keyInput resignFirstResponder];
}
    
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"ste:%@",textField.text);
    return YES;
}
    
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextSelfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selfchatcell"];
    return cell;
}
    
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
