package com.example.mobileapp

import android.content.Intent
import android.net.Uri
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.mobileapp/whatsapp"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "sendWhatsAppMessage") {
                val phone = call.argument<String>("phone")
                val message = call.argument<String>("message")
                val imagePath = call.argument<String>("imagePath")
                
                if (phone != null && message != null && imagePath != null) {
                    try {
                        val file = File(imagePath)
                        val uri = FileProvider.getUriForFile(
                            this,
                            "${applicationContext.packageName}.fileprovider",
                            file
                        )
                        
                        val intent = Intent(Intent.ACTION_SEND)
                        intent.type = "image/jpeg"
                        intent.setPackage("com.whatsapp")
                        intent.putExtra(Intent.EXTRA_TEXT, message)
                        intent.putExtra(Intent.EXTRA_STREAM, uri)
                        intent.putExtra("jid", "$phone@s.whatsapp.net")
                        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                        
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("WHATSAPP_ERROR", e.message, null)
                    }
                } else {
                    result.error("INVALID_ARGUMENTS", "Missing required arguments", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
