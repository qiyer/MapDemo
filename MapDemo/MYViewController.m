//
//  MYViewController.m
//  MapDemo
//
//  Copyright © 2016年 qiye. All rights reserved.
//

#import "MYViewController.h"
#import "BBTableViewCell.h"
#import "AATableViewCell.h"

@interface MYViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIView * uiview;
@end

@implementation MYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"AATableViewCell" bundle:nil] forCellReuseIdentifier:@"AATableViewCell"];
    [_tableView registerClass:[BBTableViewCell class] forCellReuseIdentifier:@"BBTableViewCell"];
    
    [self.view addSubview:_tableView];
    
    self.title = @"TableView Test";
    
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    _uiview = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 375, 64)];
    _uiview.backgroundColor = [UIColor blueColor];
    _uiview.userInteractionEnabled = NO;
    _uiview.alpha = 0.0;
    [self.navigationController.navigationBar insertSubview:_uiview atIndex:0];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"contentOffset"]){
        CGFloat offset = self.tableView.contentOffset.y;
        CGFloat xx = (offset +64 )/(100.0 + 64.0);
        _uiview.alpha = xx;
        

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < 9){
        return 220;
    }
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BBTableViewCell"];
    if(indexPath.row>8){
        AATableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AATableViewCell"];
        return cell;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
