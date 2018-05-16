//
//  YOKLineChartViewController.m
//  chartsDemo
//
//  Created by ve2 on 2018/5/16.
//  Copyright © 2018年 ve2. All rights reserved.
//

#import "YOKLineChartViewController.h"
//#import "ZheXianTu-Bridging-Header.h"
//#import "UIColor+expand.h"
//
//
//#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface YOKLineChartViewController ()
@property (nonatomic,strong) LineChartView *LineChartView;

@end

@implementation YOKLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //折线图
    [self setupLineChartView];
}

#pragma mark - 折线图
-(void )setupLineChartView
{
    self.LineChartView = [[LineChartView alloc] init];
    self.LineChartView.delegate = self;//设置代理
    [self.view addSubview:self.LineChartView];
    CGFloat width = ScreenWidth-40;
    CGFloat height = 300;
    self.LineChartView.frame = CGRectMake(20, (ScreenHeight-height)*0.5, width, height);
    self.LineChartView.backgroundColor =  [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
    self.LineChartView.noDataText = @"暂无数据";
    
    
    //设置交互样式
    self.LineChartView.scaleYEnabled = NO;//取消Y轴缩放
    self.LineChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    self.LineChartView.dragEnabled = YES;//启用拖拽图标
    self.LineChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    self.LineChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    
    
    //设置X轴样式
    ChartXAxis *xAxis = self.LineChartView.xAxis;
    xAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    //    xAxis.spaceBetweenLabels = 4;//设置label间隔
    xAxis.labelTextColor = [UIColor colorWithHexString:@"#057748"];//label文字颜色
    
    //设置Y轴样式
    self.LineChartView.rightAxis.enabled = NO;//不绘制右边轴
    ChartYAxis *leftAxis = self.LineChartView.leftAxis;//获取左边Y轴
    leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
    leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    leftAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//Y轴线宽
    leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
    //    leftAxis.valueFormatter = [[NSNumberFormatter alloc] init];//自定义格式
    //    leftAxis.valueFormatter.positiveSuffix = @" $";//数字后缀单位
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    leftAxis.labelTextColor = [UIColor colorWithHexString:@"#057748"];//文字颜色
    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    
    //设置网格线样式
    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
    leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    
    //添加限制线
    ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"限制线"];
    limitLine.lineWidth = 2;
    limitLine.lineColor = [UIColor greenColor];
    limitLine.lineDashLengths = @[@5.0f, @5.0f];//虚线样式
    limitLine.labelPosition = ChartLimitLabelPositionRightTop;//位置
    limitLine.valueTextColor = [UIColor colorWithHexString:@"#057748"];//label文字颜色
    limitLine.valueFont = [UIFont systemFontOfSize:12];//label字体
    [leftAxis addLimitLine:limitLine];//添加到Y轴上
    leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在折线图的后面
    
    //设置折线图描述及图例样式
    self.LineChartView.chartDescription.text = @"折线图描述";//折线图描述
    self.LineChartView.chartDescription.textColor = [UIColor darkGrayColor];
    self.LineChartView.legend.form = ChartLegendFormLine;//图例的样式
    self.LineChartView.legend.formSize = 30;//图例中线条的长度
    self.LineChartView.legend.textColor = [UIColor darkGrayColor];//图例文字颜色
    
    [self setupLineChartViewData];
}

-(void)setupLineChartViewData
{
    int xVals_count = 12;//X轴上要显示多少条数据
    double maxYVal = 100;//Y轴的最大值
    
    //创建数据
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < xVals_count; i++) {
        double mult = maxYVal + 1;
        double valY = (double)(arc4random_uniform(mult));
        ChartDataEntry *entry =  [[ChartDataEntry alloc] initWithX:(i+1) y:valY];
        [values addObject:entry];
        
    }
    
    LineChartDataSet *set1 = nil;
    if (self.LineChartView.data.dataSetCount > 0) {
        set1 = (LineChartDataSet *)self.LineChartView.data.dataSets[0];
        set1.values = values;
        //通知data去更新
        [self.LineChartView.data notifyDataChanged];
        //通知图表去更新
        [self.LineChartView notifyDataSetChanged];
    }else{
        
        //创建LineChartDataSet对象
        set1 = [[LineChartDataSet alloc] initWithValues:values label:@"data折线"];
        //自定义set的各种属性
        //设置折线的样式
        set1.drawIconsEnabled = NO;
        set1.formLineWidth = 1.1;//折线宽度
        set1.formSize = 15.0;
        set1.drawValuesEnabled = YES;//是否在拐点处显示数据
        set1.valueColors = @[[UIColor whiteColor]];//折线拐点处显示数据的颜色
        [set1 setColor:[UIColor colorWithHexString:@"#007FFF"]];//折线颜色
        //折线拐点样式
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        //第二种填充样式:渐变填充
        set1.drawFilledEnabled = YES;//是否填充颜色
        NSArray *gradientColors =  @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,
                                     (id)[ChartColorTemplates colorFromString:@"#FF007FFF"].CGColor];
        CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        set1.fillAlpha = 1.0f;//透明度
        set1.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
        CGGradientRelease(gradientRef);//释放gradientRef
        
        //点击选中拐点的交互样式
        set1.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
        set1.highlightColor = [UIColor colorWithHexString:@"#c83c23"];//点击选中拐点的十字线的颜色
        set1.highlightLineWidth = 1.1/[UIScreen mainScreen].scale;//十字线宽度
        set1.highlightLineDashLengths = @[@5, @5];//十字线的虚线样式
        
        //将 LineChartDataSet 对象放入数组中
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont systemFontOfSize:8.f]];//文字字体
        [data setValueTextColor:[UIColor whiteColor]];//文字颜色
        
        self.LineChartView.data = data;
        //这里可以调用一个加载动画即1s出来一个绘制点
        [self.LineChartView animateWithXAxisDuration:1.0f];
    }
}



@end
