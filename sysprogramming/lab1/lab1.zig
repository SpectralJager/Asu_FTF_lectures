const std = @import("std");
const fs = std.fs;
const linux = std.os.linux;

pub fn main() !void {
    var dir = try fs.cwd().openIterableDir("input", .{});
    defer dir.close();
    var it = dir.iterate();
    var output = try fs.cwd().openFile("output/output", .{ .mode = .write_only });
    defer output.close();
    while (try it.next()) |entry| {
        var file = try dir.dir.openFile(entry.name, .{ .mode = .read_write });
        defer file.close();
        var data = try file.readToEndAlloc(std.heap.page_allocator, 65535);
        var spaces = std.mem.count(u8, data, " ");
        var tabs = std.mem.count(u8, data, "\t");
        var blancs = spaces + tabs;
        try std.fmt.format(output.writer(), "input/{s} -> {d}\n", .{ entry.name, blancs });
    }
}
