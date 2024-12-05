package com.example.locate_me
import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.locate_me/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "openMyketUrl") {
                openMyketUrl(result)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun openMyketUrl(result: MethodChannel.Result) {
        val url = "myket://comment?id=com.example.locate_me"
        val intent = Intent(Intent.ACTION_VIEW).apply {
            data = Uri.parse(url)
        }

        try {
            startActivity(intent)
            result.success("Success")
        } catch (e: ActivityNotFoundException) {
            result.error("ACTIVITY_NOT_FOUND", "No application can handle this URL.", null)
        }
    }
}
