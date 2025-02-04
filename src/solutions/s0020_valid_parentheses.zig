const std = @import("std");

fn is_valid(s: []const u8) bool {
    var stack = std.ArrayList(u8).init(std.heap.page_allocator);
    defer stack.deinit();

    for (s) |c| {
        switch (c) {
            // * 遇到左括号，将对应的右括号入栈
            '(' => stack.append(')') catch unreachable,
            '[' => stack.append(']') catch unreachable,
            '{' => stack.append('}') catch unreachable,
            // * 遇到右括号，检查是否与栈顶元素匹配
            // * 其他字符都是非法的
            else => if (stack.pop() != c) return false,
        }
    }

    return stack.items.len == 0;
}

test is_valid {
    const cases: [4]struct {
        s: []const u8,
        expected: bool,
    } = .{
        .{
            .s = "()",
            .expected = true,
        },
        .{
            .s = "()[]{}",
            .expected = true,
        },
        .{
            .s = "(]",
            .expected = false,
        },
        .{
            .s = "([])",
            .expected = true,
        },
    };

    inline for (cases) |c| {
        const actual = is_valid(c.s);

        try std.testing.expectEqual(c.expected, actual);
    }
}
