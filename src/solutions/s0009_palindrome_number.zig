const std = @import("std");

fn is_palindrome(x: i32) bool {
    // * 负数或最后一位是 0 且不是 0 本身的数字不是回文数
    if (x < 0 or (@rem(x, 10) == 0 and x != 0)) {
        return false;
    }

    var num: i32 = 0;
    var reverted: i32 = 0;

    // * 当原始数字大于反转后的数字时, 说明还没处理到一半
    while (num > reverted) {
        reverted = reverted * 10 + @rem(num, 10);
        num = @divTrunc(num, 10);
    }

    // * 当数字长度为偶数时，1221 -> x = 12, reversed = 12
    // * 当数字长度为奇数时，12321 -> x = 12, reversed = 123
    return num == reverted or num == @divTrunc(reverted, 10);
}

test is_palindrome {
    const cases: [3]struct {
        x: i32,
        expected: bool,
    } = .{
        .{
            .x = 121,
            .expected = true,
        },
        .{
            .x = -121,
            .expected = false,
        },
        .{
            .x = 10,
            .expected = false,
        },
    };

    inline for (cases) |c| {
        const actual = is_palindrome(c.x);

        try std.testing.expectEqual(c.expected, actual);
    }
}
