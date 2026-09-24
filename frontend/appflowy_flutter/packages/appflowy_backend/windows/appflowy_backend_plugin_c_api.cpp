#include "include/appflowy_backend/appflowy_backend_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "include/appflowy_backend/app_flowy_backend_plugin.h"

void AppFlowyBackendPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar)
{
    AppFlowyBackendPluginRegisterWithRegistrar(registrar);
}
