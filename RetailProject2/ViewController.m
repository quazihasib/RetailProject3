//
//  ViewController.m
//  RetailProject2
//
//  Created by Quazi Ridwan Hasib on 21/6/17.
//  Copyright © 2017 Quazi Ridwan Hasib. All rights reserved.
//

#import "ViewController.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestKivaLoansURL [NSURL URLWithString:@"https://api.meetup.com/2/groups?lat=51.509980&lon=-0.133700&page=20&key=1f5718c16a7fb3a5452f45193232"]

@interface ViewController ()

@end


@implementation ViewController

@synthesize views;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

   
    NSURL *url = [NSURL URLWithString:@"https://quaziridwanhasibcom.000webhostapp.com/all_files/get_all_products/getAllProducts.php"];
    [self getData:url];
    
//1920 x 1080
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //NSLog(@"view will Appear");
    
    //CGRect screen = [[UIScreen mainScreen] bounds];
    //CGFloat width = CGRectGetWidth(screen);
    //NSLog(@"width:%f",width);
    //CGFloat height = CGRectGetHeight(screen);
    //NSLog(@"height:%f",height);
    
//
//    CGRect frame = self.views.frame;
//    // frame.size.height = self.view.bounds.size.height;
//    frame.size.width = width;
//    frame.size.height = height-200;
//    self.views.frame = frame;
    
//    CGSize scrollableSize = CGSizeMake(width, height);
//    [self.views.:scrollableSize];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) getData : (NSURL*) url
{
    NSError* error;
    NSData* data = [NSData dataWithContentsOfURL: url];
    //NSLog(@"url:%@",url);
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    
    //NSArray* latestLoan = [json objectForKey:@"loans"];
    //NSLog(@"json:%@",json);
    
    //NSArray* resultFields = [json objectForKey:@"result"];
    //NSLog(@"json:%@",json);
    //NSLog(@"id:%@",[latestLoan valueForKey:@"id"]);
    //NSLog(@"name:%@", [latestLoan valueForKey:@"name"]);
    //NSLog(@"result:%@",latestLoan);
    
    //NSLog(@"productTable:%@",[json valueForKey:@"productTable"]);
    
    NSArray * values =[[NSArray alloc] init];
    values = [json allValues];
    //NSLog(@"values=%@",values);
    
    NSArray * keys =[[NSArray alloc] init];
    keys = [json allKeys];
    //NSLog(@"keys=%@",keys);
    
//    NSMutableArray *arrayName;
//    arrayName = [json valueForKey:keys[1]];
//    NSLog(@"arrayName:%@",arrayName);
    
    
    //NSLog(@"vals=%@",[values ]);
//    NSString *arrayResult = [json objectForKey:@"productTable"];
//    NSLog(@"name=%@",arrayResult);
    
//    for (int i=0; i<[json count]; i++) {
//        //NSString *arrayResult = [json objectAtIndex:i];
//        //NSLog(@"name=%@",[json objectAtIndex:i]);
//        NSLog(@"name=%@",[json valueForKey:@"field1"]);
//        
//    }
    
//    NSMutableArray *arrayName;
//    NSString* s = [resultFields valueForKey:@"productTable"];
//    NSLog(@"arrayName = %@", s);
//    
//    NSMutableArray *arrayImage;
//    arrayImage = [NSMutableArray arrayWithObjects:[resultFields valueForKey:@"table1"],nil];
//    NSLog(@"arrayImage = %@", arrayImage);
    
    [self saveDictonary: json : @"json"];
    [self saveData: keys : @"keys"];
    
}

//save the username
-(void)saveData:(NSArray*)name :(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:name forKey:key];
    [defaults synchronize];
}

//save the json
-(void)saveDictonary:(NSDictionary*)name :(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:name forKey:key];
//    [defaults synchronize];
    
    NSMutableDictionary *yourDictionary = [[NSMutableDictionary  alloc] init];
    yourDictionary = [name mutableCopy];
    [defaults setObject:name forKey:key];
    [defaults synchronize];
}




@end
