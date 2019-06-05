package com.aftarobot.flutter_mongodb_mobile;

import android.os.Build;
import android.util.Log;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
// Base Stitch Packages
import com.mongodb.stitch.android.core.Stitch;
import com.mongodb.stitch.android.core.StitchAppClient;

// Packages needed to interact with MongoDB and Stitch
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;

// Necessary component for working with MongoDB Mobile
import com.mongodb.stitch.android.services.mongodb.local.LocalMongoDbService;


/** FlutterMongodbMobilePlugin */
public class FlutterMongodbMobilePlugin implements MethodCallHandler {
  /** Plugin registration. */
  static StitchAppClient client;
  static MongoClient mobileClient;
  public static final String TAG = FlutterMongodbMobilePlugin.class.getSimpleName();

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_mongodb_mobile");
    channel.setMethodCallHandler(new FlutterMongodbMobilePlugin());

    Log.d(TAG, "registerWith: \uD83D\uDE0E  \uD83D\uDE0E Registering FlutterMongodbMobilePlugin channel: 🧩 " + channel.toString());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {

    switch (call.method) {
      case "getPlatformVersion":
        Log.d(TAG, "onMethodCall: getPlatformVersion requested");
        result.success("ANDROID " + android.os.Build.VERSION.RELEASE + " " + Build.DEVICE
        + " " + Build.MODEL);
        Log.d(TAG, "onMethodCall: getPlatformVersion: 🧩🧩🧩 MANUFACTURER: " + Build.MANUFACTURER);
        break;
      case "setAppID":
        String key = call.argument("appID");
        Log.d(TAG, "onMethodCall: appID received : " + key + ", setting up MongoDB client");
        try {
          client = Stitch.initializeDefaultAppClient(key);
          mobileClient =
                  client.getServiceClient(LocalMongoDbService.clientFactory);
        } catch (Exception e) {
          Log.e(TAG, "\uD83D\uDC7F \uD83D\uDC7F \uD83D\uDC7F registerWith: failed to get MongoDB mobile client", e );
        }
        Log.d(TAG, "🍎 🍎 🍎 onMethodCall: setAppID 🧩🧩🧩 " + key + "  🧩🧩🧩");
        result.success("We cool with appID: 🍎 " + key + " 🍎 on the wild side");
        break;
        default:
          result.notImplemented();
          break;
    }
  }
}
