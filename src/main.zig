const c = @import("c.zig");

export fn main(argc: c_int, argv: [*]const [*:0]const u8) void {
    _ = argc;
    _ = argv;
    _ = c.consoleInit(null);
    defer c.consoleExit(null);

    while (c.appletMainLoop()) {
        c.consoleUpdate(null);
    }
}
