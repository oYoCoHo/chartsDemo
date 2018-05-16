//
//  YOKPieChartViewController.m
//  chartsDemo
//
//  Created by ve2 on 2018/5/16.
//  Copyright © 2018年 ve2. All rights reserved.
//

#import "YOKPieChartViewController.h"

@interface YOKPieChartViewController ()
@property (nonatomic,strong) PieChartView *pieChartView;

@end

@implementation YOKPieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //饼状图
    [self setupPieChartView];
}

-(void )setupPieChartView
{
    self.pieChartView = [[PieChartView alloc] init];
    self.pieChartView.backgroundColor = [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
    [self.view addSubview:self.pieChartView];
    CGFloat width = ScreenWidth-40;
    CGFloat height = width;
    self.pieChartView.frame = CGRectMake(20, (ScreenHeight-height)*0.5, width, height);
    self.pieChartView.backgroundColor =  [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
    
    // 基本样式
    [self.pieChartView setExtraOffsetsWithLeft:30 top:0 right:30 bottom:0];//饼状图距离边缘的间隙
    self.pieChartView.usePercentValuesEnabled = YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
    self.pieChartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
    //    self.pieChartView.drawSlicesUnderHoleEnabled = YES;//是否显示区块文本,默认是false空心
    
    //设置饼状图中间的空心样式
    self.pieChartView.drawHoleEnabled = YES;//饼状图是否是空心
    self.pieChartView.holeRadiusPercent = 0.5;//空心半径占比
    self.pieChartView.holeColor = [UIColor clearColor];//空心颜色
    self.pieChartView.transparentCircleRadiusPercent = 0.52;//半透明空心半径占比
    self.pieChartView.transparentCircleColor = [UIColor colorWithRed:210/255.0 green:145/255.0 blue:165/255.0 alpha:0.3];//半透明空心的颜色
    
    //设置饼状图中心的文本
    if (self.pieChartView.isDrawHoleEnabled == YES) {
        self.pieChartView.drawCenterTextEnabled = YES;//是否显示中间文字
        //普通文本
        //        self.pieChartView.centerText = @"饼状图";//中间文字
        //富文本
        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"饼状图"];
        [centerText setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
                                    NSForegroundColorAttributeName: [UIColor orangeColor]}
                            range:NSMakeRange(0, centerText.length)];
        self.pieChartView.centerAttributedText = centerText;
    }
    
    //设置饼状图描述
    self.pieChartView.chartDescription.text = @"饼状图示例";
    self.pieChartView.chartDescription.font = [UIFont systemFontOfSize:10];
    self.pieChartView.chartDescription.textColor = [UIColor grayColor];
    
    //设置饼状图图例样式
    self.pieChartView.legend.maxSizePercent = 1;//图例在饼状图中的大小占比, 这会影响图例的宽高
    self.pieChartView.legend.formToTextSpace = 5;//文本间隔
    self.pieChartView.legend.font = [UIFont systemFontOfSize:10];//字体大小
    self.pieChartView.legend.textColor = [UIColor grayColor];//字体颜色
    //    self.pieChartView.legend.position = ChartLegendPositionBelowChartCenter;//图例在饼状图中的位置
    self.pieChartView.legend.form = ChartLegendFormCircle;//图示样式: 方形、线条、圆形
    self.pieChartView.legend.formSize = 12;//图示大小
    
    [self setupPieChartViewData];
    
}

-(void)setupPieChartViewData
{
    double mult = 100;
    int count = 5;//饼状图总共有几块组成
    
    //每个区块的数据
    NSArray *xVals = @[@"西瓜",@"苹果",@"香蕉",@"荔枝",@"哈密瓜"];
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        double randomVal = arc4random_uniform(mult + 1);
        
        PieChartDataEntry *entry =  [[PieChartDataEntry alloc] initWithValue:randomVal label:xVals[i]];
        [yVals addObject:entry];
        
    }
    
    
    
    //dataSet
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:yVals label:@"PieChartDataSet"];
    dataSet.drawValuesEnabled = YES;//是否绘制显示数据
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    dataSet.colors = colors;//区块颜色
    dataSet.sliceSpace = 0;//相邻区块之间的间距
    dataSet.selectionShift = 8;//选中区块时, 放大的半径
    dataSet.xValuePosition = PieChartValuePositionInsideSlice;//名称位置
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数据位置
    //数据与区块之间的用于指示的折线样式
    dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
    dataSet.valueLinePart1Length = 0.5;//折线中第一段长度占比
    dataSet.valueLinePart2Length = 0.4;//折线中第二段长度最大占比
    dataSet.valueLineWidth = 1;//折线的粗细
    dataSet.valueLineColor = [UIColor brownColor];//折线颜色
    
    //data
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;//小数位数
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];//设置显示数据格式
    [data setValueTextColor:[UIColor brownColor]];
    [data setValueFont:[UIFont systemFontOfSize:10]];
    
    
    self.pieChartView.data = data;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
