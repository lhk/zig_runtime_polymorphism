const Iterator = @This();

ptr: *anyopaque,
vtable: *const VTable,

pub const VTable = struct {
    next: *const fn (ctx: *anyopaque) ?u32,
};

pub fn next(self: Iterator) ?u32 {
    return self.vtable.next(self.ptr);
}
