//
//  ViewController.m
//  SortForOC
//
//  Created by zhangke on 15/10/15.
//  Copyright © 2015年 zhangke. All rights reserved.
//

#import "ViewController.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *string = @"http://testchat.client.3g.fang.com/HttpSendMessageByXF?command=xf_notice&form=新房帮小秘书&housetype=xiaomishu&housetitle=您有{test-苹果汇}的客户&message=您好，{test-苹果汇}的客户：{400来电4453}（156****4453）已下单，快去抢客户吧！&msgContent=82563&sendto=x:esf-seco83300834&purpose=qdds_qiangdan&u=xf_common&vc=704274e970f77800211b4ffbf5e323be";
    
    NSURL *url = [NSURL URLWithString:[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",data);
    }];
    
    [task resume];

    
    self.myLabel.text = @"sdflkjsdfsdfsdfdsfdsfsdsfsdf";
    
    
    /**
     *      
     UIForceTouchCapabilityUnknown = 0,
     UIForceTouchCapabilityUnavailable = 1,
     UIForceTouchCapabilityAvailable = 2
     */
    NSLog(@"UIForceTouchCapability--%ld",self.traitCollection.forceTouchCapability);
    /**
     *  shortcutItem
     */
    [self createShortcutItems];
    
    
    /**
     *  spotlight搜索
     */
    [self spotlightIndexing];
    
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@5,@3,@1,@0,@7,@9,@4,@6,@2,@8]];
    
    [self bubbleSortForArray:array];
//    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:array.count];
//    [self mergeSortForArray:array tempArray:tempArray start:0 end:array.count - 1];
//    [self quickSortForArray:array left:0 right:array.count-1];
    
    NSInteger index = [self binarySearchFromArray:array withObject:2 low:0 high:array.count - 1];
    NSLog(@"binarySearch--%ld",index);
    
    for (NSNumber *num in array) {
        NSLog(@"%d",[num intValue]);
    }
    
}

#pragma mark --二分查找
/**
 *  二分查找
 */
-(NSInteger)binarySearchFromArray:(NSArray*)array withObject:(NSInteger)key low:(NSInteger)low high:(NSInteger)high{
    
    NSInteger mid = low + (high - low) / 2;
    if (low > high) {
        return -1;
    }else{
        if ([array[mid] integerValue] == key) {
            return mid;
        }else if([array[mid] integerValue] > key){
            return [self binarySearchFromArray:array withObject:key low:low high:mid - 1];
        }else{
            return [self binarySearchFromArray:array withObject:key low:mid + 1 high:high];
        }
    }
    
}


#pragma mark --冒泡排序
/**
 *  冒泡排序
 */
-(void)bubbleSortForArray:(NSMutableArray*)array{
    
    for (int j = 0; j < array.count - 1; j++) {
        for (int i = 0; i < array.count - 1 - j; i++) {
            if (array[i] > array[i+1]) {
                [array exchangeObjectAtIndex:i withObjectAtIndex:i+1];
            }
        }
    }
    
}


#pragma mark --归并排序
/**
 *  递归处理
 */
-(void)mergeSortForArray:(NSMutableArray*)array tempArray:(NSMutableArray*)tempArray start:(NSInteger)startIndex end:(NSInteger)endIndex{
    
    NSInteger midIndex;
    if (startIndex < endIndex) {
        midIndex = (startIndex + endIndex) / 2;
        [self mergeSortForArray:array tempArray:tempArray start:startIndex end:midIndex];
        [self mergeSortForArray:array tempArray:tempArray start:midIndex + 1 end:endIndex];
        [self mergeSortForArray:array tempArray:tempArray start:startIndex mid:midIndex end:endIndex];
    }
}
/**
 *  归并操作
 */
-(void)mergeSortForArray:(NSMutableArray*)array tempArray:(NSMutableArray*)tempArray start:(NSInteger)startIndex mid:(NSInteger)midIndex end:(NSInteger)endIndex{
    
    NSInteger i = startIndex,j = midIndex + 1,k = startIndex;
    /**
     *  比较两个指针所指向的元素，选择相对小的元素放入到合并空间，并移动指针到下一位置
     *  重复步骤3直到某一指针超出序列尾
     */
    while (i != midIndex + 1 && j != endIndex + 1) {
        if (array[i] < array[j]) {
            tempArray[k++] = array[i++];
        }else{
            tempArray[k++] = array[j++];
        }
    }
    /**
     *  将另一序列剩下的所有元素直接复制到合并序列尾
     */
    while (i != midIndex + 1) {
        tempArray[k++] = array[i++];
    }
    while (j != endIndex + 1) {
        tempArray[k++] = array[j++];
    }
    /**
     *  赋值给原数组
     */
    for (i = startIndex; i <= endIndex; i++) {
        array[i] = tempArray[i];
    }
    
}


#pragma mark --快速排序
/**
 *  快速排序
 *
 *  @param array 排序数组
 *  @param left  起始位置
 *  @param right 结束位置
 */
-(void)quickSortForArray:(NSMutableArray*)array left:(NSInteger)left right:(NSInteger)right{
    
    if (left >= right){/*如果左边索引大于或者等于右边的索引就代表已经整理完成一个组了*/
        return;
    }
    NSInteger i = left;
    NSInteger j = right;
    NSNumber *key = array[left];
    
    while (i < j) {/*控制在当组内寻找一遍*/
        
        while (i < j && key <= array[j]){/*寻找结束的条件
                                          1，找到一个小于或者大于key的数（这里<=找到小于key的值结果为升序，>=找到大于key的值结果为降序）
                                          2，没有符合条件1的，并且i与j的大小没有反转*/
            j--;//向前寻找
        }
//        [array exchangeObjectAtIndex:i withObjectAtIndex:j];//交换位置
        
        while (i < j && key >= array[i]){//向后寻找，与上相反的值，并交换位置
            i++;
        }
        [array exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    
    [array exchangeObjectAtIndex:left withObjectAtIndex:i];
    
    [self quickSortForArray:array left:left right:i - 1];
    [self quickSortForArray:array left:i + 1 right:right];
    
}


#pragma mark --3D Touch标签
-(void)createShortcutItems{
    UIApplicationShortcutItem *shortcutItem = [[UIApplicationShortcutItem alloc]initWithType:@"add" localizedTitle:@"Add" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:nil ];
    
//    NSMutableArray *items = [NSMutableArray arrayWithArray:[UIApplication sharedApplication].shortcutItems];
//    [items addObject:shortcutItem];
    [UIApplication sharedApplication].shortcutItems = @[shortcutItem];
    
}


#pragma mark --spotlight搜索
/**
 *  spotlight
 */
-(void)spotlightIndexing{
    /**
     属性设置
     */
    CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc]initWithItemContentType:(NSString*)kUTTypeImage];
    
    attributeSet.title = @"Test_k";
    attributeSet.contentDescription = @"这是k的实验性学习spotlight的第一条描述";
    attributeSet.keywords = @[@"Test_k"];
    
    UIImage *image = [UIImage imageNamed:@"10"];
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
    attributeSet.thumbnailData = imageData;
    
    /**
     *  item
     */
    NSString *identifier = [NSString stringWithFormat:@"%@",attributeSet.title];
    CSSearchableItem *item = [[CSSearchableItem alloc]initWithUniqueIdentifier:identifier domainIdentifier:@"com.Fang.SortForOC" attributeSet:attributeSet];
    
    /**
     *  IndexSearchableItems
     */
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:@[item] completionHandler:^(NSError * _Nullable error) {
        NSLog(@"IndexSearchableItems");
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
