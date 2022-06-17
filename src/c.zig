pub usingnamespace @cImport({
    @cDefine("__SWITCH__", {});
    @cInclude("switch.h");
    @cInclude("EGL/egl.h");
    @cInclude("EGL/eglext.h");
    @cInclude("glad/glad.h");
});
