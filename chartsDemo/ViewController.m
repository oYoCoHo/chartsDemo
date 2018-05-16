//
//  ViewController.m
//  chartsDemo
//
//  Created by ve2 on 2018/5/16.
//  Copyright © 2018年 ve2. All rights reserved.
//

#import "ViewController.h"
#import "YOKLineChartViewController.h"
#import "YOKPieChartViewController.h"
#import "YOKBarChartViewController.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
        NSArray *arr = @[@"折线图",@"饼状图",@"柱状图"];
        for (int i=0; i<3; i++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(130, i*(44+30)+100, 100, 44)];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:30];
            btn.tag = i;
            [btn addTarget:self action:@selector(pushChartViewWithItem:) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.cornerRadius = 10;
            btn.layer.masksToBounds = YES;
            btn.backgroundColor = [UIColor yellowColor];
            [self.view addSubview:btn];
    
        }
}

-(void)pushChartViewWithItem:(UIButton*)item
{
    if (item.tag == 0) {
        
        YOKLineChartViewController *lineChartView = [[YOKLineChartViewController alloc]init];
        [self.navigationController pushViewController:lineChartView animated:YES];
    }else if (item.tag == 1){
        YOKPieChartViewController *pieChartView = [[YOKPieChartViewController alloc]init];
        [self.navigationController pushViewController:pieChartView animated:YES];
        
    }else if (item.tag == 2){
        YOKBarChartViewController *barChartView = [[YOKBarChartViewController alloc]init];
        [self.navigationController pushViewController:barChartView animated:YES];
        
    }
}

@end
