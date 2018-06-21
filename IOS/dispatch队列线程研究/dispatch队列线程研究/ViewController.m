//
//  ViewController.m
//  dispatch队列线程研究
//
//  Created by lingda on 2017/11/25.
//  Copyright © 2017年 btc. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property (nonatomic,strong)dispatch_queue_t serial;;
@property (nonatomic,strong)dispatch_queue_t concurrent;;
@property (nonatomic,strong)dispatch_queue_t mainQueue;;
@property (nonatomic,strong)dispatch_queue_t globalQueue;;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createQueue];

    
    [self syncSerial];
    
//    [self blockIntroduced];
    
    
    
}

- (void)syncSerial
{
//    2017-11-27 16:28:29.392589+0800 dispatch队列线程研究[1359:61169] thread-<NSThread: 0x174271fc0>{number = 3, name = (null)}---0
//    2017-11-27 16:28:32.398239+0800 dispatch队列线程研究[1359:61169] thread-<NSThread: 0x174271fc0>{number = 3, name = (null)}---1
//    2017-11-27 16:28:32.398825+0800 dispatch队列线程研究[1359:61169] thread-<NSThread: 0x174271fc0>{number = 3, name = (null)}+++0
//    2017-11-27 16:28:32.399156+0800 dispatch队列线程研究[1359:61169] thread-<NSThread: 0x174271fc0>{number = 3, name = (null)}+++1
    /*
     欧拉可以在最---0前面 也可以在---0 ---1之间  也可以在 +++0  +++1 之间
     也可以在+++0之前  而数字的打印必定是---0---1+++0+++1 或者 +++0+++1---0---
     总结：1.异步开启的serial队列，里面的内容必定是一个任务执行完了在去执行另一个任务
          2.同一个serial队列，必定是在同一个线程里面，这样才可以保证顺序
     */
    
    dispatch_async(_serial, ^{
        for (int i = 0; i < 2; i ++) {
            if (i == 1) {
                sleep(3);
            }
            NSLog(@"thread-%@---%d",[NSThread currentThread],i);
        }
    });
    
    dispatch_async(_serial, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"thread-%@+++%d",[NSThread currentThread],i);
        }
    });
    NSLog(@"欧拉");
}

-(void)blockIntroduced
{
    /*
     一：-------------------------------
     2016-02-05 21:07:12.622 GcdTest[7229:164997] dispatch_sync-serial-0
     mainThread:<NSThread: 0x7fad93407dd0>{number = 1, name = main}
     2016-02-05 21:07:12.623 GcdTest[7229:164997] dispatch_sync-serial-1
     mainThread:<NSThread: 0x7fad93407dd0>{number = 1, name = main}
     2016-02-05 21:07:12.623 GcdTest[7229:164997] dispatch_sync-serial-2
     mainThread:<NSThread: 0x7fad93407dd0>{number = 1, name = main}
     
     第一种方式可见，串行队列是在主线程里完成的，因为是串行队列，所以打印%d是有顺序的。
     */
    for(int i=0;i<3;i++){
        dispatch_sync(_serial, ^{
            NSLog(@"dispatch_sync-serial-%d\n mainThread:%@",i,[NSThread currentThread]);
        });
    }

    
    /*
     二：-------------------------------
     2016-02-05 21:09:26.422 GcdTest[7241:165846] dispatch_sync-concurrent-0
     mainThread:<NSThread: 0x7face9d01d20>{number = 1, name = main}
     2016-02-05 21:09:26.422 GcdTest[7241:165846] dispatch_sync-concurrent-1
     mainThread:<NSThread: 0x7face9d01d20>{number = 1, name = main}
     2016-02-05 21:09:26.422 GcdTest[7241:165846] dispatch_sync-concurrent-2
     mainThread:<NSThread: 0x7face9d01d20>{number = 1, name = main}
     
     第二种方式可以发现同样还是在主线程里执行并行队列，(虽然是并行队列，但这时候依然在同一个线程里执行)
     */
    for(int i=0;i<3;i++){
        dispatch_sync(_concurrent, ^{
            NSLog(@"dispatch_sync-concurrent-%d\n mainThread:%@",i,[NSThread currentThread]);
            
        });
    }
    
    
    /*
     三：-------------------------------
     打印结果：dispatch_sync-mainQueue，发现主线程被堵塞
     分析：mainQueue里存在任务1，同步线程任务，这两个任务，当执行dispatch_sync时，把打印任务2加入主队列，想要打印2必须等之前所有的任务都执行完成，这时候因为主队列里有同步线程任务，这时候相当于自己在等自己执行完成，进入死循环。
     
     for(int i=0;i<3;i++){
     NSLog(@"dispatch_sync-mainQueue");
         dispatch_sync(mainQueue, ^{
         NSLog(@"dispatch_sync-mainQueue-%d\n mainThread:%@",i,[NSThread currentThread]);
         });
     }
     */
    
    
    /*
     四：-------------------------------
     2016-02-05 21:22:41.107 GcdTest[7338:172870] dispatch_sync-globalQueue-0
     mainThread:<NSThread: 0x7feadad050b0>{number = 1, name = main}
     2016-02-05 21:22:41.107 GcdTest[7338:172870] dispatch_sync-globalQueue-1
     mainThread:<NSThread: 0x7feadad050b0>{number = 1, name = main}
     2016-02-05 21:22:41.107 GcdTest[7338:172870] dispatch_sync-globalQueue-2
     mainThread:<NSThread: 0x7feadad050b0>{number = 1, name = main}
     
     打印结果可以看出依然是主线程
     */
    for(int i=0;i<3;i++){
        dispatch_sync(_globalQueue, ^{
            
            NSLog(@"dispatch_sync-globalQueue-%d\n mainThread:%@",i,[NSThread currentThread]);
            
        });
    }
    

    /*
     五：
     2016-02-05 22:32:14.957 GcdTest[7499:191789] dispatch_async-serial-0
     Thread:<NSThread: 0x7fd7eaf10c70>{number = 3, name = (null)}
     2016-02-05 22:32:16.962 GcdTest[7499:191789] dispatch_async-serial-1
     Thread:<NSThread: 0x7fd7eaf10c70>{number = 3, name = (null)}
     2016-02-05 22:32:16.963 GcdTest[7499:191789] dispatch_async-serial-2
     Thread:<NSThread: 0x7fd7eaf10c70>{number = 3, name = (null)}
     
     可以看出创建了一个线程， 在串行队列里串行执行的
     */
    for (int i=0; i<3; i++) {
        dispatch_async(_serial, ^{
            if (i==1) {
                sleep(2);
            }
            NSLog(@"dispatch_async-serial-%d\n Thread:%@",i,[NSThread currentThread]);
        });
    }
    
    
    
    /*
     六：
     2016-02-05 22:10:07.083 GcdTest[7425:184003] dispatch_async-concurrent-2
     Thread:<NSThread: 0x7fcda24bcd00>{number = 4, name = (null)}
     2016-02-05 22:10:07.083 GcdTest[7425:183982] dispatch_async-concurrent-0
     Thread:<NSThread: 0x7fcda2502310>{number = 3, name = (null)}
     2016-02-05 22:10:10.083 GcdTest[7425:184002] dispatch_async-concurrent-1
     Thread:<NSThread: 0x7fcda2436180>{number = 5, name = (null)}
     
     分析可以看出创建了多个线程，任务执行顺序不一定（时间差不多的话）
     */
    for (int i=0; i<3; i++) {
        dispatch_async(_concurrent, ^{
            if (i==1) {
                sleep(3);
            }
            NSLog(@"dispatch_async-concurrent-%d\n Thread:%@",i,[NSThread currentThread]);
        });
    }
    
    
    
    /*
     七：
     2016-02-05 22:15:03.709 GcdTest[7460:186485] dispatch_async-mainQueue-0
     Thread:<NSThread: 0x7fbb28703fb0>{number = 1, name = main}
     2016-02-05 22:15:06.710 GcdTest[7460:186485] dispatch_async-mainQueue-1
     Thread:<NSThread: 0x7fbb28703fb0>{number = 1, name = main}
     2016-02-05 22:15:06.710 GcdTest[7460:186485] dispatch_async-mainQueue-2
     Thread:<NSThread: 0x7fbb28703fb0>{number = 1, name = main}
     
     可以看出这种情况还是在当前线程环境中执行，并不创建线程，因为是在主队列里，顺序执行
     */
    
    for (int i=0; i<3; i++) {
        dispatch_async(_mainQueue, ^{
            if (i==1) {
                sleep(3);
            }
            NSLog(@"dispatch_async-mainQueue-%d\n Thread:%@",i,[NSThread currentThread]);
        });
    }
    
    
    /*
     八：
     2016-02-05 22:17:58.306 GcdTest[7482:188067] dispatch_async-globalQueue-1
     Thread:<NSThread: 0x7fa281e24580>{number = 4, name = (null)}
     2016-02-05 22:17:58.306 GcdTest[7482:188099] dispatch_async-globalQueue-2
     Thread:<NSThread: 0x7fa281e321c0>{number = 5, name = (null)}
     2016-02-05 22:17:58.307 GcdTest[7482:188069] dispatch_async-globalQueue-0
     Thread:<NSThread: 0x7fa281e262b0>{number = 3, name = (null)}
     
     可以看出创建了多个线程，执行顺序并不一定
     */
    for (int i=0; i<3; i++) {
        dispatch_async(_globalQueue, ^{
            
            NSLog(@"dispatch_async-globalQueue-%d\n Thread:%@",i,[NSThread currentThread]);
        });
    }
    
    
}

- (void)createQueue
{
    _serial = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    _concurrent = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
    _mainQueue = dispatch_get_main_queue();
    _globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}


@end
