//
//  LLScanController.m
//  DePoint
//
//  Created by LZB on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//


#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

#import "LLScanController.h"
#import <AVFoundation/AVFoundation.h>
#import "LLIntroController.h"
#import "LLFlowController.h"

@interface LLScanController ()<UITabBarDelegate,AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/**边框*/
@property (nonatomic,weak) UIImageView *QRImageView;
/**扫描*/
@property (nonatomic,weak) UIImageView *scanImageView;
/**最底层的view*/
@property (nonatomic,weak) UIView *bottomView;

@property (nonatomic,strong) AVCaptureDevice *device;
@property (nonatomic,strong) AVCaptureDeviceInput *input;
@property (nonatomic,strong) AVCaptureMetadataOutput *output;
@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic) AVCaptureVideoPreviewLayer *lay;
@property (strong, nonatomic) CIDetector *detector;

@end

@implementation LLScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"扫描";
    
    [self setupNav];
    
    [self setupContentView];
    
    [self startScan];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //开始捕获
    [self.session startRunning];
    [self startQRAnimation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //停止扫描
    [self.session stopRunning];
}
#pragma mark - 开始扫描
- (void)startScan
{
    // 判断有没有相机
    //判断是否可以打开相机，模拟器此功能无法使用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    //如果没获得权限
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲,请先到系统“隐私”中打开相机权限哦" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    //获取摄像设备
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    //创建输出流
    self.output = [[AVCaptureMetadataOutput alloc] init];
    //设置代理 在主线程里刷新
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //初始化链接对象
    self.session = [[AVCaptureSession alloc] init];
    //高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [self.session addInput:self.input];
    [self.session addOutput:self.output];
    //设置扫码支持的编码格式
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                        AVMetadataObjectTypeEAN13Code,
                                        AVMetadataObjectTypeEAN8Code,
                                        AVMetadataObjectTypeCode128Code,];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    layer.frame = self.view.layer.bounds;
    
    [self.view.layer insertSublayer:layer atIndex:0];
    

    //开始捕获
    [self.session startRunning];
    
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //设置扫码支持的编码格式
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                        AVMetadataObjectTypeEAN13Code,
                                        AVMetadataObjectTypeEAN8Code,
                                        AVMetadataObjectTypeCode128Code,];
    self.bottomView.frame = CGRectMake((ScreenW-200)*0.5, 0.5*(ScreenH-100),200, 100);
    [self startQRAnimation];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate(限制扫描区域)
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count == 0) {
        NSLog(@"%@", metadataObjects);
        return;
    }
    
    if (metadataObjects.count > 0) {
        
        [self.scanImageView.layer removeAllAnimations];
        
        //停止扫描
        [self.session stopRunning];
        
        //移除图层
//        [self.view.layer removeFromSuperlayer];
        
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
        NSLog(@"%@", metadataObject.stringValue);
        
        
        //扫描得到的文本 可以拿到扫描后的文本做其他操作哦
        if (metadataObject.stringValue.length == 13) {
            
            LLIntroController *vc = [[LLIntroController alloc] initWithStr:metadataObject.stringValue];
         [self presentViewController:vc animated:YES completion:nil];
            NSLog(@"%@", metadataObject.stringValue);
            
        }
        if (metadataObject.stringValue.length == 20) {

            LLFlowController *vc = [[LLFlowController alloc] initWithStr:metadataObject.stringValue];
            [self presentViewController:vc animated:YES completion:nil];
            NSLog(@"%@", metadataObject.stringValue);
            
        }
    }
    

}

- (void)setupNav
{
    self.navigationItem.title = @"扫描药品条形码";
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftItem)];
    
    leftBtn.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
}

- (void)clickLeftItem
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 创建UI
- (void)setupContentView
{
    // 最底层的view
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake((ScreenW-200)*0.5, (ScreenH-200)*0.5, ScreenW - 20, 200)];
    bottomView.center = self.view.center;
    [self.view addSubview:bottomView];
    bottomView.layer.borderColor = [UIColor whiteColor].CGColor;
    bottomView.layer.borderWidth = 1;
    self.bottomView = bottomView;
    
    // 提示
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, ScreenW - 40, 40)];
    lable.font = [UIFont systemFontOfSize:14];
    lable.text = @"将药品包装上的条形码(13位)或药品监管码(20位)放入扫描框内即可扫描";
    lable.numberOfLines = 0;
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
    
    // 边框
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:bottomView.bounds];
    imageView.image = [UIImage imageNamed:@"qrcode_border"];
    [bottomView addSubview:imageView];
    self.QRImageView = imageView;
    
    // 扫描效果
    UIImageView *scanView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bottomView.frame.size.width, 0)];
    scanView.image = [UIImage imageNamed:@"qrcode_scanline_qrcode"];
    [bottomView addSubview:scanView];
    self.scanImageView = scanView;
    
    [self startQRAnimation];
    
    // 灯泡
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenW-50)*0.5, ScreenH-180, 50, 50)];
    [btn setBackgroundImage:[UIImage imageNamed:@"l"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"l_s"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(clickLight:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - 开始二维码动画
- (void)startQRAnimation
{
    [self.scanImageView.layer removeAllAnimations];
    
    self.QRImageView.frame = self.bottomView.bounds;
    self.bottomView.center = self.view.center;
    
    CGRect frame = self.scanImageView.frame;
    frame.size.height = 0;
    self.scanImageView.frame = frame;
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        CGRect frame = self.scanImageView.frame;
        frame.size.height = self.bottomView.frame.size.height;
        self.scanImageView.frame = frame;
    } completion:nil];
}

- (void)clickLight:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self turnTorchOn:YES];
    } else {
        [self turnTorchOn:NO];
    }
}

#pragma mark - 开关灯
- (void)turnTorchOn:(bool)on
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}

@end
