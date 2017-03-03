#import <Foundation/Foundation.h>

@interface NSString (RemoveEmoji)

// 是否包含数字
- (BOOL)isIncludingNumber;

// 移除数字
- (instancetype)removedNumberString;

// 是否包含字母
- (BOOL)isIncludingLetter;

// 移除字母
- (instancetype)removedLetterString;

// 是否包含表情
- (BOOL)isIncludingEmoji;

// 移除表情
- (instancetype)removedEmojiString;

// 是否包含符号
- (BOOL)isIncludingSymbol;

// 移除符号
- (instancetype)removedSymbolString;

// 移除空格
- (instancetype)removedBlankString;

- (BOOL) isBlankString;

@end
