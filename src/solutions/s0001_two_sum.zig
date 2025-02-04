const std = @import("std");

fn two_sum(nums: []const i32, target: i32) []const i32 {
    var hash_table = std.AutoHashMap(i32, i32).init(std.heap.page_allocator);
    defer hash_table.deinit();

    for (nums, 0..) |value, key| {
        // * 计算目标值与当前元素的差值
        const diff = target - value;

        // * 如果哈希表中存在差值，则返回差值与当前元素的索引
        if (hash_table.contains(diff)) {
            return &.{ hash_table.get(diff).?, @intCast(key) };
        }

        // * 将当前元素及其索引存入哈希表
        hash_table.put(value, @intCast(key)) catch unreachable;
    }

    return &.{};
}

test two_sum {
    const cases: [4]struct {
        nums: []const i32,
        target: i32,
        expected: []const i32,
    } = .{
        .{
            .nums = &.{ 2, 7, 11, 15 },
            .target = 9,
            .expected = &.{ 0, 1 },
        },
        .{
            .nums = &.{ 3, 2, 4 },
            .target = 6,
            .expected = &.{ 1, 2 },
        },
        .{
            .nums = &.{ 3, 3 },
            .target = 6,
            .expected = &.{ 0, 1 },
        },
        .{
            .nums = &.{ 1, 2 },
            .target = 4,
            .expected = &.{},
        },
    };

    inline for (cases) |c| {
        const actual = two_sum(c.nums, c.target);

        try std.testing.expectEqualSlices(i32, c.expected, actual);
    }
}
