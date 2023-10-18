const std = @import("std");
const fs = std.fs;
const cout = std.io.getStdOut().writer();
const string = []const u8;

pub fn main() !void {
    var dir = try fs.cwd().openIterableDir("input", .{});
    defer dir.close();
    var it = dir.iterate();
    var map = std.AutoHashMap(u64, u64).init(std.heap.page_allocator);
    var maxInode: u64 = 0;
    while (try it.next()) |entry| {
        if (entry.kind == fs.File.Kind.sym_link) {
            var link = try dir.dir.openFile(entry.name, .{});
            var stata = try link.stat();
            if (map.contains(stata.inode)) {
                var val = map.get(stata.inode) orelse 0;
                val += 1;
                try map.put(stata.inode, val);
                if (map.get(maxInode) orelse 0 < val) {
                    maxInode = stata.inode;
                }
            } else {
                try map.put(stata.inode, 1);
            }
        }
    }
    try printResult(maxInode, map, dir);
}

pub fn printResult(maxInode: u64, map: std.HashMap(u64, u64, std.hash_map.AutoContext(u64), 80), dir: std.fs.IterableDir) !void {
    var it = dir.iterate();
    var maxValue: u64 = map.get(maxInode) orelse 0;
    var kt = map.keyIterator();
    while (kt.next()) |key| {
        if (map.get(key.*) orelse 0 == maxValue) {
            try cout.print("{d} -> #{d}[ ", .{ key.*, maxValue });
            it.reset();
            while (try it.next()) |entry| {
                if (entry.kind == fs.File.Kind.sym_link) {
                    var link = try dir.dir.openFile(entry.name, .{});
                    var stata = try link.stat();
                    if (stata.inode == key.*) {
                        try cout.print("{s} ", .{entry.name});
                    }
                }
            }
            try cout.print("]\n", .{});
        }
    }
}
