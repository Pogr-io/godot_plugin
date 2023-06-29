#include "pogr_plugin.h"
#include <stdio.h>
#ifdef _WIN32
#include <Windows.h>
#include "execute.hpp"
#endif
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/classes/editor_plugin.hpp>
#include <godot_cpp/variant/utility_functions.hpp>

pogr_plugin *pogr_plugin::singleton = nullptr;

void pogr_plugin::_bind_methods()
{
    ClassDB::bind_method(D_METHOD("debug"), &pogr_plugin::debug);
    ClassDB::bind_method(D_METHOD("get_sys_monitor_info"), &pogr_plugin::get_sys_monitor_info);
}

pogr_plugin *pogr_plugin::get_singleton()
{
    return singleton;
}
pogr_plugin::pogr_plugin()
{
    ERR_FAIL_COND(singleton != nullptr);
    singleton = this;
}
pogr_plugin::~pogr_plugin()
{
    ERR_FAIL_COND(singleton != this);
    singleton = nullptr;
}

void pogr_plugin::debug()
{
#ifdef _WIN32
    MEMORYSTATUSEX statex;

    statex.dwLength = sizeof(statex);

    GlobalMemoryStatusEx(&statex);
    UtilityFunctions::print(vformat("Maximum RAM capacity in KB: %s", statex.ullTotalPhys / 1024));
#endif
}

Dictionary pogr_plugin::get_sys_monitor_info()
{
    Dictionary sys_monitor_info;
    sys_monitor_info["max_phys_memory"] = "unknown";
    sys_monitor_info["free_phys_memory"] = "unknown";
    sys_monitor_info["max_page_memory"] = "unknown";
    sys_monitor_info["free_page_memory"] = "unknown";
    sys_monitor_info["max_virt_memory"] = "unknown";
    sys_monitor_info["free_virt_memory"] = "unknown";

    sys_monitor_info["cpu_load_percentage"] = "unknown";
#ifdef _WIN32
    MEMORYSTATUSEX statex;
    statex.dwLength = sizeof(statex);
    GlobalMemoryStatusEx(&statex);
    sys_monitor_info["max_phys_memory"] = statex.ullTotalPhys;
    sys_monitor_info["free_phys_memory"] = statex.ullAvailPhys;
    sys_monitor_info["max_page_memory"] = statex.ullTotalPageFile;
    sys_monitor_info["free_page_memory"] = statex.ullAvailPageFile;
    sys_monitor_info["max_virt_memory"] = statex.ullTotalVirtual;
    sys_monitor_info["free_virt_memory"] = statex.ullAvailVirtual;
    sys_monitor_info["cpu_load_percentage"] = String(exec("wmic cpu get LoadPercentage /value").c_str()).replace("\r\n\r\nLoadPercentage=", "").replace("\r\n\r\n\r\n\r\n", "");
#endif
    sys_monitor_info.make_read_only();
    return sys_monitor_info;
}