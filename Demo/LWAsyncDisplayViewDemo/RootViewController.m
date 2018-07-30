/********************* 有任何问题欢迎反馈给我 liuweiself@126.com ****************************************/
/***************  https://github.com/waynezxcv/Gallop 持续更新 ***************************/
/******************** 正在不断完善中，谢谢~  Enjoy ******************************************************/


#import "RootViewController.h"

#import "RichTextDemo1ViewController.h"
#import "MomentsViewController.h"
#import "ArticleListViewController.h"
#import "ImageDemoViewController.h"
#import "GifController.h"
#import "TestViewController.h"
#import "GifListController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = attributes;

    self.title = @"测试";

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark -


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"LWTextStorage使用示例";
            break;
        case 1:
            cell.textLabel.text = @"LWImageStorage使用示例";
            break;
        case 2:
            cell.textLabel.text = @"Feed List 示例";
            break;
        case 3:
            cell.textLabel.text = @"进行HTML解析示例";
            break;
        case 4:
            cell.textLabel.text = @"使用Gif示例";
            break;
        case 5:
            cell.textLabel.text = @"使用GifList示例";
            break;
        case 6:
            cell.textLabel.text = @"异步性能示例";
            break;
        default:
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.row) {
        case 0: {
            RichTextDemo1ViewController *vc = [[RichTextDemo1ViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1: {
            ImageDemoViewController *vc = [[ImageDemoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2: {
            MomentsViewController *vc = [[MomentsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3: {
            ArticleListViewController *vc = [[ArticleListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4: {
            GifController *vc = [[GifController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 5: {
            GifListController *vc = [[GifListController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 6: {
            TestViewController *vc = [TestViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }

        default:
            break;
    }
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED {
    return UITableViewCellAccessoryDisclosureIndicator;
}

@end
