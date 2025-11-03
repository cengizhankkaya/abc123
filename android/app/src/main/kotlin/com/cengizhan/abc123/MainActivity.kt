package com.cengizhan.abc123

import android.os.Bundle
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsControllerCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // FlutterActivity için edge-to-edge yapılandırması
        // Not: FlutterActivity, ComponentActivity extend etmediği için
        // enableEdgeToEdge() yerine manuel olarak yapılandırıyoruz
        window?.let { window ->
            // Edge-to-edge desteği için sistem pencerelerinin içeriğe uyumunu ayarla
            WindowCompat.setDecorFitsSystemWindows(window, false)
            
            // Android 15'te deprecated API'ler yerine WindowInsetsController kullan
            // Bu, eski setStatusBarColor/setNavigationBarColor çağrılarını önler
            val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
            windowInsetsController?.apply {
                // Sistem çubuklarının görünümünü ayarla
                // (setStatusBarColor yerine bu kullanılmalı)
                isAppearanceLightStatusBars = true
                isAppearanceLightNavigationBars = true
            }
        }
    }
} 