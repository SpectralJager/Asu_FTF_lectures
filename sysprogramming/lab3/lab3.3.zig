const std = @import("std");
const fs = std.fs;
const cout = std.io.getStdOut().writer();
const string = []const u8;

var min: i32 = -1;
var nameList = std.ArrayList(string).init(std.heap.page_allocator);

pub fn main() !void {
    var out1 = try fs.cwd().openFile("output/output", .{ .mode = .read_only });
    defer out1.close();
    var data = try out1.readToEndAlloc(std.heap.page_allocator, 65536);
    var it = std.mem.split(u8, data, "\n");
    while (it.next()) |row| {
        if (row.len == 0) break;
        var towIt = std.mem.split(u8, row, " -> ");
        var name = towIt.next().?;
        var value = try std.fmt.parseInt(i32, towIt.next().?, 10);
        if (min == -1 or min > value) {
            min = value;
            nameList.clearAndFree();
            try nameList.append(name);
        } else if (min == value) {
            try nameList.append(name);
        }
    }
    var thread = try std.Thread.spawn(.{}, sub, .{});
    thread.join();
}

fn sub() !void {
    var out2 = try fs.cwd().openFile("output/output2", .{ .mode = .write_only });
    defer out2.close();
    try std.fmt.format(cout, "{d} -> {s}\n", .{ min, nameList.items });
    try std.fmt.format(out2.writer(), "{d} -> {s}\n", .{ min, nameList.items });
}
