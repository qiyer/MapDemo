//
//  MapViewController.m
//  MapDemo
//
//  Copyright © 2016年 qiye. All rights reserved.
//
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotationView.h>
#import "QYAnnotation.h"
#import "MKMapView+ZoomLevel.h"
#import "DestinationMode.h"

@interface MapViewController ()<MKMapViewDelegate>

@end

@implementation MapViewController{
    UIView            *   uiView;
    CLLocationManager *   locationManager;
    MKMapView         *   maMapView;
    MKAnnotationView  *   annotationView;
    DestinationMode   *   destinationMode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地图使用";
    
    [self initMap];
}

-(void) initMap
{
    
    destinationMode = [DestinationMode initWithName:@"上海政府" desc:@"对，就是这个地方！" latitude:@"31.230344" longitude:@"121.47411346"];
    
    maMapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:maMapView];
    //设置代理
    maMapView.delegate=self;
    //请求定位服务
    locationManager=[[CLLocationManager alloc]init];
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [locationManager requestWhenInUseAuthorization];
    }
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    maMapView.userTrackingMode = MKUserTrackingModeFollow;
    //设置地图类型
    maMapView.mapType=MKMapTypeStandard;
    //添加大头针
    [self addAnnotation];
}

-(void)addAnnotation{
    
    CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(destinationMode.destinationLatitude.floatValue, destinationMode.destinationLongitude.floatValue);
    
    QYAnnotation *annotation1=[[QYAnnotation alloc]init];
    annotation1.title= destinationMode.destinationName;
    annotation1.subtitle= destinationMode.destinationDesc;
    annotation1.coordinate=location1;
    
    [maMapView setCenterCoordinate:location1 zoomLevel:10 animated:NO];
    [maMapView addAnnotation:annotation1];
    [maMapView selectAnnotation:annotation1 animated:YES];
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[QYAnnotation class]]) {
        static NSString *key1=@"QYAnnotation";
        annotationView=[mapView dequeueReusableAnnotationViewWithIdentifier:key1];
        //如果缓存池中不存在则新建
        if (!annotationView) {
            annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
            annotationView.canShowCallout=true;//允许交互点击
            annotationView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
            [btn setBackgroundImage:[UIImage imageNamed:@"common_green_line"] forState:UIControlStateNormal];
            [btn setTitle:@"到这去" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(turnAction:) forControlEvents:UIControlEventTouchUpInside];
            annotationView.rightCalloutAccessoryView=btn;//定义详情左侧视图
            annotationView.selected = YES;
        }
        //修改大头针视图
        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
        annotationView.annotation=annotation;
        annotationView.image=[UIImage imageNamed:@"common_map_site"];//设置大头针视图的图片
        
        return annotationView;
    }else {
        return nil;
    }
}

-(void)turnAction:(id)sender{
    [self doAppleNavigation];
}

-(void)doAppleNavigation{
    NSDictionary *options=@{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard),MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving};
    CLLocationCoordinate2D fromCoordinate   = maMapView.userLocation.location.coordinate;
    CLLocationCoordinate2D toCoordinate   = CLLocationCoordinate2DMake(destinationMode.destinationLatitude.floatValue, destinationMode.destinationLongitude.floatValue);
    MKPlacemark *fromPlacemark = [[MKPlacemark alloc] initWithCoordinate:fromCoordinate
                                                       addressDictionary:nil];
    
    MKPlacemark *toPlacemark   = [[MKPlacemark alloc] initWithCoordinate:toCoordinate
                                                       addressDictionary:nil];
    
    MKMapItem *fromItem = [[MKMapItem alloc] initWithPlacemark:fromPlacemark];
    fromItem.name =@"当前位置";
    MKMapItem *toItem=[[MKMapItem alloc]initWithPlacemark:toPlacemark];
    toItem.name = destinationMode.destinationName;
    [MKMapItem openMapsWithItems:@[fromItem,toItem] launchOptions:options];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
