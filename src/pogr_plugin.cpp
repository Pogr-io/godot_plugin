#include "pogr_plugin.h"
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/classes/editor_plugin.hpp>
#include <godot_cpp/variant/utility_functions.hpp>

pogr_plugin *pogr_plugin::singleton = nullptr;

void pogr_plugin::_bind_methods()
{
    ClassDB::bind_method(D_METHOD("debug"), &pogr_plugin::debug);
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
    UtilityFunctions::print("Plugin debug is working!");
}