//
//  BBTableViewCell.m
//  MapDemo
//
//  Copyright © 2016年 qiye. All rights reserved.
//

#import "BBTableViewCell.h"

@implementation BBTableViewCell{
    UIImageView * imageView;
    UILabel     * labelQ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if(self = [ super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        labelQ = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 350, 50)];
        labelQ.text = @"nmnnnnnn";
        [self addSubview:labelQ];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 150, 150)];
        imageView.backgroundColor = [UIColor grayColor];

//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            
//            NSURLSession * session = [NSURLSession sharedSession];
//            NSURLSessionDataTask * down = [session dataTaskWithURL:[NSURL URLWithString:@"http://avatar.csdn.net/C/A/5/1_benbenxiongyuan.jpg"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    UIImage * image = [UIImage imageWithData:data];
//                    imageView.image = image;
//                    NSLog(@"down ok %@",response);
//                });
//            }];
//            
//            [down resume];
//        });
        [self addSubview:imageView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //异步绘制
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        CGRect rect = {0,0,375,200};
        UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        //整个内容的背景
        [[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1] set];
        CGContextFillRect(context, rect);
        
        CGRect subFrame = {10,10,355,180};
        //转发内容的背景
        [[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1] set];
        CGContextFillRect(context, subFrame);
        [[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] set];
        CGContextFillRect(context, CGRectMake(0, subFrame.origin.y, rect.size.width, .5));
        
        
        //将绘制的内容以图片的形式返回，并调主线程显示
        UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.frame = rect;
            imageView.image = nil;
            imageView.image = temp;
        });
    });
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
