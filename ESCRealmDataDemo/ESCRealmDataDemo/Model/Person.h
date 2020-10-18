//
//  Person.h
//  ESCRealDataDemo
//
//  Created by xiang on 2020/9/28.
//

#import <Realm/Realm.h>
#import "Dog.h"
#import "Book.h"


RLM_ARRAY_TYPE(Book)

@interface Person : RLMObject

@property(nonatomic,copy)NSString* name;

@property(nonatomic,assign)int age;

@property(nonatomic,strong)Dog* dog;

@property(nonatomic,strong)RLMArray<Book *><Book>* bookArray;

@end

