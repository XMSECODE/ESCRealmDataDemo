//
//  Dog.h
//  ESCRealDataDemo
//
//  Created by xiang on 2020/9/28.
//

#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : RLMObject

@property(nonatomic,copy)NSString* name;

@property(nonatomic,assign)int age;


@end

NS_ASSUME_NONNULL_END
