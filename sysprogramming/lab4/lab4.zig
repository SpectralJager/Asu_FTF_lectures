const std = @import("std");
const fs = std.fs;
const cout = std.io.getStdOut().writer();
const string = []const u8;

pub fn main() !void {
    var iterableDir = try fs.cwd().openIterableDir("input", .{});
    defer iterableDir.close();
    // создаем хеш таблицу
    var inodeMap = std.AutoHashMap(u64, u64).init(std.heap.page_allocator);
    var dirIterator = iterableDir.iterate();
    var maxInode: u64 = 0;
    while (try dirIterator.next()) |dirEntry| { // проходим через каждый файл
        if (dirEntry.kind == fs.File.Kind.sym_link) {
            var linkFile = try iterableDir.dir.openFile(dirEntry.name, .{});
            var linkFileMeta = try linkFile.stat(); // читаем метаданные
            if (inodeMap.contains(linkFileMeta.inode)) { // проверяем, есть ли данный inode в таблице
                var inodeCount = inodeMap.get(linkFileMeta.inode) orelse 0; // получаем его кол-во
                inodeCount += 1; // увеличиваем
                try inodeMap.put(linkFileMeta.inode, inodeCount); // сохраняем
                if (inodeMap.get(maxInode) orelse 0 < inodeCount) { // проверяем, если оно максимально
                    maxInode = linkFileMeta.inode; // сохраняем данный inode как максимальный
                }
            } else { // если inode в таблице нет, то заносим его
                try inodeMap.put(linkFileMeta.inode, 1);
            }
        }
    }
    try printResult(maxInode, inodeMap, iterableDir); // выводим результат на экран
}

pub fn printResult(maxInode: u64, inodeMap: std.HashMap(u64, u64, std.hash_map.AutoContext(u64), 80), iterableDir: std.fs.IterableDir) !void {
    var dirIterator = iterableDir.iterate();
    var maxInodeCount: u64 = inodeMap.get(maxInode) orelse 0; // получаем макс значение
    var mapKeyIterator = inodeMap.keyIterator();
    while (mapKeyIterator.next()) |key| { // проходим таблицу по ключам
        if (inodeMap.get(key.*) orelse 0 == maxInodeCount) { // если inode имеет макс кол-во файлов
            // выводим inode и макс. число
            try cout.print("{d} -> #{d}[ ", .{ key.*, maxInodeCount });
            dirIterator.reset(); // сбрасываем итератор входной директории
            // проходимся по всем файлам в поисках с данным inode
            while (try dirIterator.next()) |dirEntry| {
                if (dirEntry.kind == fs.File.Kind.sym_link) { // если файл это ссылка
                    var linkFile = try iterableDir.dir.openFile(dirEntry.name, .{});
                    var linkFileMeta = try linkFile.stat(); // получаем метаданные
                    if (linkFileMeta.inode == key.*) { // выводим, если нашли необходимый inode
                        try cout.print("{s} ", .{dirEntry.name});
                    }
                }
            }
            try cout.print("]\n", .{}); // закрывающий вывод
        }
    }
}
