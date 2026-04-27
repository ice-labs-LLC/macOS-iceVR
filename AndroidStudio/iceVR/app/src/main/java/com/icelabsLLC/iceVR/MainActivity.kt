package com.icelabsLLC.iceVR

import android.app.Activity
import android.os.Bundle
import android.view.Gravity
import android.view.WindowManager
import android.widget.FrameLayout
import android.widget.TextView
import java.net.NetworkInterface

class MainActivity : Activity() {

    private lateinit var ipText: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)

        // Head-locked overlay layout
        val layout = FrameLayout(this).apply {
            setBackgroundColor(0x00000000) // transparent
        }

        ipText = TextView(this).apply {
            ipText.text = getString(R.string.ip_display, getLocalIpAddress())
            textSize = 32f
            setTextColor(0xFFFFFFFF.toInt())
            setBackgroundColor(0xAA000000.toInt())
            setPadding(40, 20, 40, 20)
        }

        val params = FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.WRAP_CONTENT,
            FrameLayout.LayoutParams.WRAP_CONTENT,
            Gravity.CENTER
        )

        layout.addView(ipText, params)
        setContentView(layout)
    }

    private fun getLocalIpAddress(): String {
        return try {
            NetworkInterface.getNetworkInterfaces()
                .toList()
                .flatMap { it.inetAddresses.toList() }
                .firstOrNull { !it.isLoopbackAddress && it.hostAddress?.contains('.') == true }
                ?.hostAddress ?: "No IP found"
        } catch (e: Exception) {
            "Error: ${e.message}"
        }
    }
}