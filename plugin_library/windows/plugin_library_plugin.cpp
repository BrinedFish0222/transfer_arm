#include "plugin_library_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

void mouseClick(int type);
void mouseMove(int x, int y);

namespace plugin_library
{

  // static
  void PluginLibraryPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarWindows *registrar)
  {
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "plugin_library",
            &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<PluginLibraryPlugin>();

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
  }

  PluginLibraryPlugin::PluginLibraryPlugin() {}

  PluginLibraryPlugin::~PluginLibraryPlugin() {}

  void PluginLibraryPlugin::HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    if (method_call.method_name().compare("getPlatformVersion") == 0)
    {
      std::ostringstream version_stream;
      version_stream << "Windows ";
      if (IsWindows10OrGreater())
      {
        version_stream << "10+";
      }
      else if (IsWindows8OrGreater())
      {
        version_stream << "8";
      }
      else if (IsWindows7OrGreater())
      {
        version_stream << "7";
      }

      result->Success(flutter::EncodableValue(version_stream.str()));
    }
    else if (method_call.method_name().compare("mouseMove") == 0)
    {
      const flutter::EncodableList *arguments = std::get_if<flutter::EncodableList>(method_call.arguments());
      if (!arguments)
      {
        result->Error("arguments error");
        return;
      }
      // 获取参数1 int
      int arg1 = std::get<int>(arguments->at(0));
      // 获取参数2
      int arg2 = std::get<int>(arguments->at(1));

      mouseMove(arg1, arg2);

      result->Success();
    }
    else if (method_call.method_name().compare("mouseClick") == 0)
    {
      const flutter::EncodableList *arguments = std::get_if<flutter::EncodableList>(method_call.arguments());
      if (!arguments)
      {
        result->Error("arguments error");
        return;
      }

      int type = std::get<int>(arguments->at(0));
      mouseClick(type);

      result->Success();
    }

    else
    {
      result->NotImplemented();
    }
  }

} // namespace plugin_library

void mouseClick(int type)
{
  if (type == 1)
  {
    // 中键点击
    mouse_event(MOUSEEVENTF_MIDDLEDOWN, 0, 0, 0, 0);
    mouse_event(MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0);
    return;
  }
  else if (type == 2)
  {
    // 右键点击
    mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
    mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
    return;
  }

  // 左键点击
  mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
  mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
}

void mouseMove(int x, int y)
{
  SetCursorPos(x, y);
}