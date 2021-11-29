package com.will.aa_wallet

import android.content.pm.PackageManager
import android.graphics.drawable.Drawable
import android.os.Build
import android.widget.ImageView
import io.flutter.embedding.android.DrawableSplashScreen
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.SplashScreen

class MainActivity : FlutterActivity() {
    companion object {
        const val SPLASH_SCREEN_META_DATA_KEY = "io.flutter.embedding.android.SplashScreenDrawable"
    }

    override fun provideSplashScreen(): SplashScreen? {
        val manifestSplashDrawable = getSplashScreenFromManifest()
        return manifestSplashDrawable?.let { DrawableSplashScreen(it, ImageView.ScaleType.FIT_XY, 0) }
    }

    private fun getSplashScreenFromManifest(): Drawable? {
        return try {
            val activityInfo = packageManager.getActivityInfo(componentName, PackageManager.GET_META_DATA)
            val metadata = activityInfo.metaData
            val splashScreenId = metadata?.getInt(SPLASH_SCREEN_META_DATA_KEY) ?: 0
            if (splashScreenId != 0) {
                if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP) {
                    resources.getDrawable(splashScreenId, theme)
                } else {
                    resources.getDrawable(splashScreenId)
                }
            } else {
                null
            }
        } catch (e: PackageManager.NameNotFoundException) {
            // This is never expected to happen.
            null
        }
    }
}