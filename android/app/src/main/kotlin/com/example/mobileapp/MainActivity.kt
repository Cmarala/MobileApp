package com.example.mobileapp

import android.Manifest
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothSocket
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.IOException
import java.io.OutputStream
import java.util.UUID

class MainActivity : FlutterActivity() {
    private val WHATSAPP_CHANNEL = "com.example.mobileapp/whatsapp"
    private val PRINTER_CHANNEL = "com.example.mobileapp/printer"
    
    private var bluetoothSocket: BluetoothSocket? = null
    private var outputStream: OutputStream? = null
    private var bluetoothAdapter: BluetoothAdapter? = null
    private val SPP_UUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB")

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // WhatsApp channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, WHATSAPP_CHANNEL).setMethodCallHandler { call, result ->
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
        
        // Printer channel
        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PRINTER_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getBondedDevices" -> {
                    if (!hasBluetoothPermissions()) {
                        result.error("PERMISSION_DENIED", "Bluetooth permissions not granted", null)
                        return@setMethodCallHandler
                    }
                    
                    try {
                        val pairedDevices = bluetoothAdapter?.bondedDevices
                        val devicesList = pairedDevices?.map { device ->
                            mapOf(
                                "name" to device.name,
                                "address" to device.address
                            )
                        } ?: emptyList()
                        result.success(devicesList)
                    } catch (e: SecurityException) {
                        result.error("BLUETOOTH_ERROR", "Security exception: ${e.message}", null)
                    } catch (e: Exception) {
                        result.error("BLUETOOTH_ERROR", e.message, null)
                    }
                }
                
                "connect" -> {
                    val address = call.argument<String>("address")
                    if (address == null) {
                        result.error("INVALID_ARGUMENT", "Device address is required", null)
                        return@setMethodCallHandler
                    }
                    
                    if (!hasBluetoothPermissions()) {
                        result.error("PERMISSION_DENIED", "Bluetooth permissions not granted", null)
                        return@setMethodCallHandler
                    }
                    
                    try {
                        val device = bluetoothAdapter?.getRemoteDevice(address)
                        if (device == null) {
                            result.error("DEVICE_NOT_FOUND", "Device not found", null)
                            return@setMethodCallHandler
                        }
                        
                        // Close existing connection if any
                        disconnect()
                        
                        bluetoothSocket = device.createRfcommSocketToServiceRecord(SPP_UUID)
                        bluetoothSocket?.connect()
                        outputStream = bluetoothSocket?.outputStream
                        
                        result.success(true)
                    } catch (e: SecurityException) {
                        result.error("BLUETOOTH_ERROR", "Security exception: ${e.message}", null)
                    } catch (e: IOException) {
                        result.error("CONNECTION_ERROR", "Failed to connect: ${e.message}", null)
                    } catch (e: Exception) {
                        result.error("BLUETOOTH_ERROR", e.message, null)
                    }
                }
                
                "disconnect" -> {
                    try {
                        disconnect()
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("DISCONNECT_ERROR", e.message, null)
                    }
                }
                
                "isConnected" -> {
                    val connected = bluetoothSocket?.isConnected ?: false
                    result.success(connected)
                }
                
                "printText" -> {
                    val text = call.argument<String>("text")
                    if (text == null) {
                        result.error("INVALID_ARGUMENT", "Text is required", null)
                        return@setMethodCallHandler
                    }
                    
                    try {
                        if (outputStream == null) {
                            result.error("NOT_CONNECTED", "Printer not connected", null)
                            return@setMethodCallHandler
                        }
                        
                        outputStream?.write(text.toByteArray())
                        outputStream?.flush()
                        result.success(true)
                    } catch (e: IOException) {
                        result.error("PRINT_ERROR", "Failed to print: ${e.message}", null)
                    } catch (e: Exception) {
                        result.error("PRINT_ERROR", e.message, null)
                    }
                }
                
                "printBytes" -> {
                    val bytesList = call.argument<List<Int>>("bytes")
                    if (bytesList == null) {
                        result.error("INVALID_ARGUMENT", "Bytes are required", null)
                        return@setMethodCallHandler
                    }
                    
                    try {
                        if (outputStream == null) {
                            result.error("NOT_CONNECTED", "Printer not connected", null)
                            return@setMethodCallHandler
                        }
                        
                        // Convert List<Int> to ByteArray
                        val bytes = bytesList.map { it.toByte() }.toByteArray()
                        outputStream?.write(bytes)
                        outputStream?.flush()
                        result.success(true)
                    } catch (e: IOException) {
                        result.error("PRINT_ERROR", "Failed to print: ${e.message}", null)
                    } catch (e: Exception) {
                        result.error("PRINT_ERROR", e.message, null)
                    }
                }
                
                else -> result.notImplemented()
            }
        }
    }
    
    private fun disconnect() {
        try {
            outputStream?.close()
            bluetoothSocket?.close()
        } catch (e: IOException) {
            // Ignore
        } finally {
            outputStream = null
            bluetoothSocket = null
        }
    }
    
    private fun hasBluetoothPermissions(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_CONNECT) == PackageManager.PERMISSION_GRANTED
        } else {
            ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH) == PackageManager.PERMISSION_GRANTED
        }
    }
    
    override fun onDestroy() {
        super.onDestroy()
        disconnect()
    }
}
