const std = @import("std");

pub fn main() !void {
    var arg1 = [_][]const u8{"./../lab1/lab1"};
    var arg2 = [_][]const u8{"./lab2"};
    var proc1 = std.process.Child.init(&arg1, std.heap.page_allocator);
    var proc2 = std.process.Child.init(&arg2, std.heap.page_allocator);

    try proc1.spawn();
    _ = try proc1.wait();
    try proc2.spawn();
    _ = try proc2.wait();
}
