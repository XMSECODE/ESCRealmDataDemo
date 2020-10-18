//
//  ViewController.m
//  ESCRealDataDemo
//
//  Created by xiang on 2020/9/28.
//

#import "ViewController.h"
#import <Realm/Realm.h>
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    // 设置新的架构版本。这个版本号必须高于之前所用的版本号（如果您之前从未设置过架构版本，那么这个版本号设置为 0）
    config.schemaVersion = 0;
    
    // 设置闭包，这个闭包将会在打开低于上面所设置版本号的 Realm 数据库的时候被自动调用
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // 目前我们还未进行数据迁移，因此 oldSchemaVersion == 0
        if (oldSchemaVersion < 1) {
            // 什么都不要做！Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构
        }
    };
    // 告诉 Realm 为默认的 Realm 数据库使用这个新的配置对象
    [RLMRealmConfiguration setDefaultConfiguration:config];
    // 现在我们已经告诉了 Realm 如何处理架构的变化，打开文件之后将会自动执行迁移
    [RLMRealm defaultRealm];
    
    
    [self createSaveObject];
    
    [self fetchData];
}

- (void)fetchData {
    RLMResults *results = [Person objectsWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"name == 'jake'"]]];
    NSLog(@"%@",results);
}

- (void)createSaveObject {
    Person *person = [[Person alloc] init];
    person.name = @"jake";
    person.age = 11;
    
    Dog *dog = [[Dog alloc] init];
    dog.name = @"bdog";
    dog.age = 3;
    person.dog = dog;
    
    Book *book1 = [[Book alloc] init];
    book1.name = @"j";
    book1.pageCount = 10;
    
    Book *book2 = [[Book alloc] init];
    book2.name = @"j";
    book2.pageCount = 10;
    
    RLMArray *bookArray = [[RLMArray alloc] initWithObjectClassName:@"Book"];
    [bookArray addObject:book1];
    [bookArray addObject:book2];
    person.bookArray = bookArray;
    //将数据加入到数据库中
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [realm addObject:person];
    }];
}


@end
