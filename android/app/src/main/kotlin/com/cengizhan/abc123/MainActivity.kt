package com.cengizhan.abc123

import android.os.Bundle
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsControllerCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        window?.let { window ->
            // İçeriğin sistem çubuklarının altına uzanabilmesi için fit davranışını kapat
            WindowCompat.setDecorFitsSystemWindows(window, false)

            // Sistem çubuklarının ikon renklerini WindowInsetsController üzerinden ayarla
            WindowInsetsControllerCompat(window, window.decorView).apply {
                isAppearanceLightStatusBars = true
                isAppearanceLightNavigationBars = true
            }
        }
    }
} 