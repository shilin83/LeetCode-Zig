const std = @import("std");

fn roman_to_int(s: []const u8) i32 {
    var hash_table = std.AutoHashMap(u8, i32).init(std.heap.page_allocator);
    defer hash_table.deinit();

    // * 创建罗马数字到整数的映射
    hash_table.put('I', 1) catch unreachable;
    hash_table.put('V', 5) catch unreachable;
    hash_table.put('X', 10) catch unreachable;
    hash_table.put('L', 50) catch unreachable;
    hash_table.put('C', 100) catch unreachable;
    hash_table.put('D', 500) catch unreachable;
    hash_table.put('M', 1000) catch unreachable;

    const length = s.len;
    var result: i32 = 0;
    var prev: i32 = 0;

    // * 从右向左遍历，处理特殊规则（如IV = 5-1 = 4）
    for (0..length) |i| {
        const curr = hash_table.get(s[length - i - 1]) orelse 0;

        // * 如果当前值小于前一个值，说明是特殊情况（如IV）
        if (curr < prev) {
            result -= curr;
        } else {
            result += curr;
        }

        prev = curr;
    }

    return result;
}

test roman_to_int {
    const cases: [5]struct {
        s: []const u8,
        expected: i32,
    } = .{
        .{
            .s = "III",
            .expected = 3,
        },
        .{
            .s = "IV",
            .expected = 4,
        },
        .{
            .s = "IX",
            .expected = 9,
        },
        .{
            .s = "LVIII",
            .expected = 58,
        },
        .{
            .s = "MCMXCIV",
            .expected = 1994,
        },
    };

    inline for (cases) |c| {
        const actual = roman_to_int(c.s);

        try std.testing.expectEqual(c.expected, actual);
    }
}
