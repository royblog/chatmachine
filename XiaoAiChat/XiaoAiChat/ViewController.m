//
//  ViewController.m
//  XiaoAiChat
//  tuling123.com  aysfwyg@163.com  Wyg741564552
//  Created by wangyaoguo on 2018/2/11.
//  Copyright © 2018年 lianluo.com. All rights reserved.
//
#import "ViewController.h"
#import "TextSelfTableViewCell.h"
#import "TextOtherTableViewCell.h"
#import "AFNetworking.h"
#import "DataModel.h"

#define BUNDLEID           @"com.xiaoaichatmachine"
#define BAIDU_API_ID       @"10822787"
#define BAIDU_APP_KEY      @"DW6gKKy3ZCbX64w2TX5pcYS6"
#define BAIDU_SECERT_KEY   @"36e14e1a245f2e683804e08dd7763204"
#define TULING_API_ADDRESS @"http://www.tuling123.com/openapi/api"
#define TULING_API_KEY     @"feb2934f92134e26adcae578f26e543c"
#define SCREEN_WIDTH       [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT      [UIScreen mainScreen].bounds.size.height
//http://www.tuling123.com/openapi/api?key=feb2934f92134e26adcae578f26e543c&userid=123456&info=天气预报
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSMutableArray *arrayChat;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"聊天机器人";
    arrayChat = [[NSMutableArray alloc]init];
    
    _keyInput.delegate = self;
    _keyInput.returnKeyType = UIReturnKeySend;
    _keyView.frame = CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45);
    _keyInput.frame = CGRectMake(30, 7, SCREEN_WIDTH - 60, 30);

    [_chatTableView registerNib:[UINib nibWithNibName:@"TextSelfTableViewCell" bundle:nil] forCellReuseIdentifier:@"selfchatcell"];
    [_chatTableView registerNib:[UINib nibWithNibName:@"TextOtherTableViewCell" bundle:nil] forCellReuseIdentifier:@"otherchatcell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapKeyBoardDown)];
    [self.view addGestureRecognizer:tap];
}
    
    
-(void)requestWithQuestion:(NSString *)q {
    
    NSDictionary *dicPara = @{
                              @"key":@"feb2934f92134e26adcae578f26e543c",
                              @"userid":@"123456",
                              @"info":q
                              };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://www.tuling123.com/openapi/api" parameters:dicPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response:%@",responseObject);
        NSString *modText = [responseObject objectForKey:@"text"];
        [arrayChat addObject:modText];
       
        [_chatTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error.description);
    }];
}

-(void)keyBoardShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    
    self.chatTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - height - 45);
    self.keyView.frame = CGRectMake(0, SCREEN_HEIGHT - height - 45, SCREEN_WIDTH, 45);
}

-(void)keyBoardHide:(NSNotification *)notification {
    self.chatTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 45);
    self.keyView.frame = CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45);
}
    
-(void)tapKeyBoardDown {
    [_keyInput resignFirstResponder];
}
    
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        NSLog(@"This is empty");
    } else {
        [arrayChat addObject:textField.text];
        [self requestWithQuestion:textField.text];
        textField.text = @"";
        [_chatTableView reloadData];
        [_chatTableView scrollToRowAtIndexPath:
         [NSIndexPath indexPathForRow:[arrayChat count] -1 inSection:0]
                              atScrollPosition: UITableViewScrollPositionBottom
                                      animated:NO];
    }
    return YES;
}
    
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayChat.count;
}
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextSelfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selfchatcell"];
    TextOtherTableViewCell *cellOther = [tableView dequeueReusableCellWithIdentifier:@"otherchatcell"];
    if ((indexPath.row + 1) % 2 == 0) {
        cellOther.textMsg.text = arrayChat[indexPath.row];
        return cellOther;
    } else {
        cell.textMsg.text = arrayChat[indexPath.row];
        return cell;
    }
}
    
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [self calDialogHeight:arrayChat[indexPath.row]];
    NSLog(@"height:%f",height);
    return height;
}
    
-(CGFloat)calDialogHeight:(NSString *)text {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    CGFloat height = rect.size.height + 20;
    if (height < 65) {
        return 65;
    }   return height;
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
