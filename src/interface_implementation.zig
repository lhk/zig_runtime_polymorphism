// for testing
const std = @import("std");

// interface
const Iterator = @import("interface_definition.zig");

// implementation of an interface, update to https://zig.news/kilianvounckx/zig-interfaces-for-the-uninitiated-an-update-4gf1
const Range = struct {
    const Self = @This();

    start: u32 = 0,
    end: u32,
    step: u32 = 1,

    pub fn next(ptr: *anyopaque) ?u32 {
        const self: *Self = @ptrCast(@alignCast(ptr));
        if (self.start >= self.end) return null;
        const result = self.start;
        self.start += self.step;
        return result;
    }

    pub fn iterator(self: *Self) Iterator {
        return .{ .ptr = self, .vtable = &.{ .next = next } };
    }
};

test "Range" {
    var range = Range{ .end = 5 };
    const iter: Iterator = range.iterator();

    try std.testing.expectEqual(@as(?u32, 0), iter.next());
    try std.testing.expectEqual(@as(?u32, 1), iter.next());
    try std.testing.expectEqual(@as(?u32, 2), iter.next());
    try std.testing.expectEqual(@as(?u32, 3), iter.next());
    try std.testing.expectEqual(@as(?u32, 4), iter.next());
    try std.testing.expectEqual(@as(?u32, null), iter.next());
    try std.testing.expectEqual(@as(?u32, null), iter.next());
}
