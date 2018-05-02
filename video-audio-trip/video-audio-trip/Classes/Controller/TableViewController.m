//
//  TableViewController.m
//  video-audio-trip
//
//  Created by 杨俊 on 2018/4/8.
//  Copyright © 2018年 qq756585379. All rights reserved.
//

#import "TableViewController.h"
#import "PlayAACViewController.h"
#import "DecodeAACViewController.h"
#import "H264DecodeDemo.h"
#import "YJExample.h"

@interface TableViewController ()
@property (nonatomic, strong) NSArray<YJExample *>*examples;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    YJExample *h264example = [YJExample exampleWithTitle:@"H264DecodeDemo" block:^{
        [self.navigationController pushViewController:[H264DecodeDemo new] animated:YES];
    }];
    
    YJExample *playAACExample = [YJExample exampleWithTitle:@"playAACExample" block:^{
        [self.navigationController pushViewController:[PlayAACViewController new] animated:YES];
    }];
    
    YJExample *decodeAACExample = [YJExample exampleWithTitle:@"decodeAACExample" block:^{
        [self.navigationController pushViewController:[DecodeAACViewController new] animated:YES];
    }];
    
    self.examples = @[h264example,playAACExample,decodeAACExample];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.examples.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJExample *example = self.examples[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = example.title;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = [cell.textLabel.textColor colorWithAlphaComponent:0.1f];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YJExample *example = self.examples[indexPath.row];
	!example.block ? : example.block();
}

@end
