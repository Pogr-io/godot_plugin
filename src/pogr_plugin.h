#ifndef POGR_PLUGIN_H
#define POGR_PLUGIN_H

#include <godot_cpp/classes/ref_counted.hpp>
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

class pogr_plugin : public RefCounted
{
    GDCLASS(pogr_plugin, Object);

    static pogr_plugin *singleton;

protected:
    static void _bind_methods();

public:
    static pogr_plugin *
    get_singleton();

    pogr_plugin();
    ~pogr_plugin();

    void debug();

    Dictionary get_sys_monitor_info();
};
#endif