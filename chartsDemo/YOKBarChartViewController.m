//
//  YOKBarChartViewController.m
//  chartsDemo
//
//  Created by ve2 on 2018/5/16.
//  Copyright © 2018年 ve2. All rights reserved.
//

#import "YOKBarChartViewController.h"

@interface YOKBarChartViewController ()
@property (nonatomic,strong) BarChartView *barChartView;

@end

@implementation YOKBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //柱状图
    [self setupBarChartView];
}

-(void )setupBarChartView
{
    self.barChartView = [[BarChartView alloc] init];
    self.barChartView.delegate = self;//设置代理
    [self.view addSubview:self.barChartView];
    CGFloat width = ScreenWidth-40;
    CGFloat height = width;
    self.barChartView.frame = CGRectMake(20, (ScreenHeight-height)*0.5, width, height);
    self.barChartView.backgroundColor =  [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
    
    
    //基本样式
    self.barChartView.backgroundColor = [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
    self.barChartView.noDataText = @"暂无数据";//没有数据时的文字提示
    self.barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
    //    self.barChartView.drawHighlightArrowEnabled = NO;//点击柱形图是否显示箭头
    self.barChartView.drawBarShadowEnabled = NO;//是否绘制柱形的阴影背景
    
    //barChartView的交互设置
    self.barChartView.scaleYEnabled = NO;//取消Y轴缩放
    self.barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    self.barChartView.dragEnabled = YES;//启用拖拽图表
    self.barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    self.barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    
    //设置barChartView的X轴样式
    ChartXAxis *xAxis = self.barChartView.xAxis;
    xAxis.axisLineWidth = 1;//设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    //    xAxis.spaceBetweenLabels = 4;//设置label间隔，若设置为1，则如果能全部显示，则每个柱形下面都会显示label
    
    xAxis.labelTextColor = [UIColor brownColor];//label文字颜色
    NSNumberFormatter *xFormatter = [[NSNumberFormatter alloc] init];
    xFormatter.numberStyle = NSNumberFormatterPercentStyle;
    xFormatter.maximumFractionDigits = 1;//小数位数
    xFormatter.multiplier = @1.f;
    xFormatter.percentSymbol = @" $";
    [xAxis setValueFormatter:[[ChartDefaultAxisValueFormatter alloc] initWithFormatter:xFormatter]];//设置显示数据格式
    
    //设置barChartView的Y轴样式
    self.barChartView.rightAxis.enabled = NO;//不绘制右边轴
    ChartYAxis *leftAxis = self.barChartView.leftAxis;//获取左边Y轴
    leftAxis.labelCount = 5;
    leftAxis.forceLabelsEnabled = NO;
    leftAxis.forceLabelsEnabled = NO;//不强制绘制制定数量的label
    //    leftAxis.showOnlyMinMaxEnabled = NO;//是否只显示最大值和最小值
    leftAxis.axisMinimum = 0;//设置Y轴的最小值
    leftAxis.drawZeroLineEnabled = YES;//从0开始绘制
    leftAxis.axisMaximum = 105;
    leftAxis.axisMaximum = 105;//设置Y轴的最大值
    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    leftAxis.axisLineWidth = 0.5;//Y轴线宽
    leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
    //Y轴上标签的样式
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    leftAxis.labelTextColor = [UIColor brownColor];//文字颜色
    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    //Y轴上标签显示数字的格式
    NSNumberFormatter *yFormatter = [[NSNumberFormatter alloc] init];
    yFormatter.numberStyle = NSNumberFormatterPercentStyle;
    yFormatter.maximumFractionDigits = 1;//小数位数
    yFormatter.multiplier = @1.f;
    yFormatter.percentSymbol = @" %";
    [leftAxis setValueFormatter:[[ChartDefaultAxisValueFormatter alloc] initWithFormatter:yFormatter]];//设置显示数据格式
    //Y轴上网格线的样式
    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
    leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    //Y轴上添加限制线
    ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"限制线"];
    limitLine.lineWidth = 2;
    limitLine.lineColor = [UIColor greenColor];
    limitLine.lineDashLengths = @[@5.0f, @5.0f];//虚线样式
    limitLine.labelPosition = ChartLimitLabelPositionRightTop;//位置
    [leftAxis addLimitLine:limitLine];//添加到Y轴上
    leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在柱形图的后面
    
    self.barChartView.legend.enabled = NO;//不显示图例说明
    self.barChartView.chartDescription.text = @"柱状图";
    
    [self setupBarChartViewData];
}

-(void)setupBarChartViewData
{
    int xVals_count = 12;//X轴上要显示多少条数据
    double maxYVal = 100;//Y轴的最大值
    
    
    //对应Y/X轴显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        double mult = maxYVal + 1;
        double val = (double)(arc4random_uniform(mult));
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:(i+1) y:val];
        [yVals addObject:entry];
    }
    
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"BarChartDataSet"];
    //    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:nil];
    //    set1.barSpace = 0.2;//柱形之间的间隙占整个柱形(柱形+间隙)的比例
    set1.drawValuesEnabled = YES;//是否在柱形图上面显示数值
    set1.highlightEnabled = NO;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    [set1 setColors:ChartColorTemplates.material];//设置柱形图颜色
    //将BarChartDataSet对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set1];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];//文字字体
    [data setValueTextColor:[UIColor orangeColor]];//文字颜色
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //自定义数据显示格式
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setPositiveFormat:@"#0.0"];
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];//设置显示数据格式
    self.barChartView.data =  data;
    
}
@end
