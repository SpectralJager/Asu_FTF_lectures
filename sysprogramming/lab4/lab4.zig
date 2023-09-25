const std = @import("std");
const fs = std.fs;
const cout = std.io.getStdOut().writer();

pub fn main() !void {
    var dir = try fs.cwd().openIterableDir("input", .{});
    defer dir.close();
    var map = std.AutoHashMap(u64, u64).init(std.heap.page_allocator);
    var it = dir.iterate();
    var max: u64 = 0;
    while (try it.next()) |entry| {
        if (entry.kind == fs.File.Kind.sym_link) {
            var link = try dir.dir.openFile(entry.name, .{});
            var stata = try link.stat();
            try cout.print("{any}\n", .{stata.inode});
            if (map.contains(stata.inode)) {
                var val = map.get(stata.inode) orelse 0;
                val += 1;
                try map.put(stata.inode, val);
                if (map.get(max) orelse 0 < val) {
                    max = stata.inode;
                }
            } else {
                try map.put(stata.inode, 0);
            }
        }
    }
    try cout.print("max -> {d}\n", .{max});
}
