//
//  main.m
//  osx-project-1
//
//  Created by Eugene Krymov on 03.11.12.
//  Copyright (c) 2012 ekrymov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

@interface Cell (mutator)   // Создем категорию mutator
-(void)mutate:(int)percent; // Описываем метод mutate: возвращает void, принимает int
@end

@implementation Cell (mutator)

-(void)mutate:(int)percent {              // Создаем имплементацию метода mutate
    
    if (percent > 100 || percent < 0) {   // Проверяем величину процентов
        NSLog(@"Wrong mutate percent value");
    } else {
    
        NSMutableArray *tmpArray = [NSMutableArray array];  // Временный массив для хранения использованных индексов
        NSString *symbol = [NSString string];               // Переменная для хранения символа для замены
        NSNumber *num = [NSNumber alloc];
        int rndIndex;
        int replaceSymbols = [self.DNA count] * percent / 100; // Количество заменяемых символов
        
        for (int i = 0; i < replaceSymbols; i++) {          // Цикл замены {replaceSymbols} случайных символов в массиве DNA
            do {                                            // Случайным образом находим уникальный индекс
                rndIndex = arc4random() % [self.DNA count];
            } while ([tmpArray containsObject:[num initWithInt:rndIndex]]);
            
            [tmpArray addObject:[num initWithInt:rndIndex]]; // Заносим индекс в массив для дальнейших проверок на уникальность
            
            do {                                             // Случайным образом находим символ для замены, отличающийся от текущего
                symbol = [self.symbols objectAtIndex:arc4random() % [self.symbols count]];
            } while ([symbol isEqual:[self.DNA objectAtIndex:rndIndex]]);
            
            [self.DNA replaceObjectAtIndex:rndIndex withObject:symbol]; // Производим замену символа
        }
    }
}

@end

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        int dnaItems = 100; // Количество элементов массива DNA
        
        Cell *dna1 = [[Cell alloc] init:dnaItems]; // Создаем объект dna1 класса Cell (ДНК-1)
        Cell *dna2 = [[Cell alloc] init:dnaItems]; // Создаем объект dna2 класса Cell (ДНК-2)
        
        NSLog(@"Hamming distance before mutator: %i", [dna1 hammingDistance:dna2]); // Выводим результат сравнения ДНК-1 и ДНК-2
        
        [dna1 mutate:40]; // Производим мутацию ДНК-1
        [dna2 mutate:60]; // Производим мутацию ДНК-2
        
        NSLog(@"Hamming distance after mutator: %i", [dna1 hammingDistance:dna2]); // Выводим результат сравнения ДНК-1 и ДНК-2
        
    }
    return 0;
}

