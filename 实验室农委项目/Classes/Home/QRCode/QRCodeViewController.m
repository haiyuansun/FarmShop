//
//  QRCodeViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/3.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "QRCodeViewController.h"


@interface QRCodeViewController()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIView *customContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanlineTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerHeightCons;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) CALayer *containerLayer;

@end

@implementation QRCodeViewController

#pragma -mark 懒加载
-(AVCaptureDeviceInput *)input{
    if (!_input) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        _input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    }
    return _input;
}
-(AVCaptureSession *)session{
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}
-(AVCaptureMetadataOutput *)output{
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        CGFloat x = self.customContainerView.y / self.view.height;
        CGFloat y = self.customContainerView.x / self.view.width;
        CGFloat width = self.customContainerView.height / self.view.height;
        CGFloat height = self.customContainerView.width / self.view.width;
        _output.rectOfInterest = CGRectMake(x, y, width, height);
//        _output.rectOfInterest = self.view.frame;
    }

    return _output;
}
-(AVCaptureVideoPreviewLayer *)previewLayer{
    if (!_previewLayer) {
        _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    }
    return _previewLayer;
}
-(CALayer *)containerLayer{
    if (!_containerLayer) {
        _containerLayer = [[CALayer alloc] init];
    }
    return _containerLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self scanQRCode];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 内部方法
- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)PhotoBtnClick:(id)sender {
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
//        return;
    UIImagePickerController *imagePickerVc = [[UIImagePickerController alloc] init];
    imagePickerVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerVc.delegate = self;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)scanQRCode{
    if (![self.session canAddInput:self.input]) {
        return;
    }
    if (![self.session canAddOutput:self.output]) {
        return;
    }
    [self.session addInput:self.input];
    [self.session addOutput:self.output];
    
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];;
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    self.previewLayer.frame = self.view.bounds;
//    [self.view.layer addSublayer:self.previewLayer];
    [self.view.layer addSublayer: self.containerLayer];
    self.containerLayer.frame = self.view.bounds;
    
    
    [self.session startRunning];
    
    
    
}
-(void)startAnimation{
    self.scanlineTopCons.constant = -self.containerHeightCons.constant;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:1.5 animations:^{
        [UIView setAnimationRepeatCount:MAXFLOAT];
        self.scanlineTopCons.constant = self.containerHeightCons.constant;
        [self.view layoutIfNeeded];
    }];
}
-(void)clearLayers{
    NSArray *sublayers = self.containerLayer.sublayers;
    for(CALayer *layer in sublayers){
        [layer removeFromSuperlayer];
    }
}
-(void)drawResultRectWithObject: (AVMetadataMachineReadableCodeObject *)obj{
    NSArray *arr = obj.corners;
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.lineWidth = 2;
    layer.fillColor = [[UIColor clearColor] CGColor];
    layer.strokeColor = [[UIColor greenColor] CGColor];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint point = CGPointZero;
    int index = 0;
    
    CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)arr[index], &point);
    index += 1;
    [path moveToPoint:point];
    while (index < arr.count) {
        CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)arr[index], &point);
        [path addLineToPoint:point];
        index += 1;
    }
    [path closePath];
    layer.path = path.CGPath;
    [self.containerLayer addSublayer:layer];
}


#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    DLog(@"%s", __func__);
    NSString *mediaType = [info objectForKey:@"UIImagePickerControllerMediaType"];
    if([mediaType isEqualToString:@"public.image"]){
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        for(CIFeature *feature in features){
            CIQRCodeFeature *f = (CIQRCodeFeature *)feature;
            DLog(@"%@\n", [f messageString]);
        }
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    [self clearLayers];
//    self.resultLabel.text = [metadataObjects.lastObject stringValue];
    
    AVMetadataObject *metadata = metadataObjects.lastObject;
    AVMetadataObject *obj = [self.previewLayer transformedMetadataObjectForMetadataObject:metadata];
//    AVMetadataMachineReadableCodeObject *obj1 = (AVMetadataMachineReadableCodeObject *)obj;
//    DLog("%@", obj1.corners);
    AVMetadataMachineReadableCodeObject *meta = (AVMetadataMachineReadableCodeObject *)metadata;
    DLog(@"%@\n", [meta stringValue]);
    self.resultLabel.text = [meta stringValue];
    [self drawResultRectWithObject:(AVMetadataMachineReadableCodeObject *)obj];
}


@end
