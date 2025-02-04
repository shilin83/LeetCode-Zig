const std = @import("std");

fn longest_common_prefix(strs: []const []const u8) []const u8 {
    // * 以第一个字符串为基准
    var prefix = strs[0];

    for (1..strs.len) |i| {
        var j: usize = 0;

        // * 逐个字符比较
        while (j < prefix.len and j < strs[i].len) : (j += 1) {
            if (prefix[j] != strs[i][j]) {
                prefix = prefix[0..j];
                break;
            }
        }
    }

    return prefix;
}

test longest_common_prefix {
    const cases: [2]struct {
        strs: []const []const u8,
        expected: []const u8,
    } = .{
        .{
            .strs = &.{ "flower", "flow", "flight" },
            .expected = "fl",
        },
        .{
            .strs = &.{ "dog", "racecar", "car" },
            .expected = "",
        },
    };

    inline for (cases) |c| {
        const actual = longest_common_prefix(c.strs);

        try std.testing.expectEqualStrings(c.expected, actual);
    }
}
