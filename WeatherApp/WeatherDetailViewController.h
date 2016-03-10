//
//  WeatherDetailViewController.h
//  WeatherApp
//
//  Created by student on 3/9/16.
//  Copyright © 2016 Canary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSDictionary *dataDictionary;
@property(nonatomic,strong) NSString *dataType;

-(void)refresh;

@end
