const std = @import("std");
const fs = std.fs;
const linux = std.os.linux;
const cout = std.io.getStdOut().writer();

pub fn main() !void {
    var dir = try fs.cwd().openIterableDir("input", .{});
    defer dir.close();
    var it = dir.iterate();
    var cp = std.process.Child.init(&.{"./lab3.2"}, std.heap.page_allocator);
    cp.stdin_behavior = .Pipe;
    while (try it.next()) |entry| {
        var file = try dir.dir.openFile(entry.name, .{ .mode = .read_only });
        defer file.close();
        var data = try file.readToEndAlloc(std.heap.page_allocator, 65535);
        var spaces = std.mem.count(u8, data, " ");
        var tabs = std.mem.count(u8, data, "\t");
        var blancs = spaces + tabs;
        // try std.fmt.format(cout, "input/{s} -> {d}\n", .{ entry.name, blancs });
        try cp.spawn();
        try std.fmt.format(cp.stdin.?.writer(), "input/{s} -> {d}\n", .{ entry.name, blancs });
        cp.stdin.?.close();
        cp.stdin = null;
        _ = try cp.wait();
    }
}
