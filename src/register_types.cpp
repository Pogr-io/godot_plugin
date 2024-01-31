#include "register_types.h"

#include <gdextension_interface.h>
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/core/defs.hpp>
#include <godot_cpp/classes/engine.hpp>
#include <godot_cpp/godot.hpp>

#include "pogr_plugin.h"
using namespace godot;

static pogr_plugin *pogrplugin;

void initialize_pogrplugin(ModuleInitializationLevel p_level)
{
    if (p_level == MODULE_INITIALIZATION_LEVEL_SCENE)
    {
        ClassDB::register_class<pogr_plugin>();
        pogrplugin = memnew(pogr_plugin);
        Engine::get_singleton()->register_singleton("pogr_plugin", pogr_plugin::get_singleton());
    }
}

void uninitialize_pogrplugin(ModuleInitializationLevel p_level)
{
    if (p_level == MODULE_INITIALIZATION_LEVEL_SCENE)
    {
        Engine::get_singleton()->unregister_singleton("pogr_plugin");
    }
}

extern "C"
{
    // Initialization.
    GDExtensionBool GDE_EXPORT pogr_plugin_init(GDExtensionInterfaceGetProcAddress p_get_proc_address, GDExtensionClassLibraryPtr p_library, GDExtensionInitialization *r_initialization)
    {
        godot::GDExtensionBinding::InitObject init_obj(p_get_proc_address, p_library, r_initialization);

        init_obj.register_initializer(initialize_pogrplugin);
        init_obj.register_terminator(uninitialize_pogrplugin);
        init_obj.set_minimum_library_initialization_level(MODULE_INITIALIZATION_LEVEL_SCENE);

        return init_obj.init();
    }
}
