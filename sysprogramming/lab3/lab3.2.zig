const std = @import("std");
const fs = std.fs;
const cout = std.io.getStdOut().writer();
const cin = std.io.getStdIn().reader();

pub fn main() !void {
    var output = try fs.cwd().openFile("output/output", .{ .mode = .read_write });
    defer output.close();
    var stat = try output.stat();
    try output.seekTo(stat.size);
    var data = try cin.readAllAlloc(std.heap.page_allocator, 65536);
    try std.fmt.format(output.writer(), "{s}", .{data});
}
