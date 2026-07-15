import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Release signing: prefer android/key.properties (gitignored) or env vars.
// Falls back to debug keystore for local builds when no release keystore is configured.
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }
}

fun propOrEnv(propKey: String, envKey: String): String? =
    keystoreProperties.getProperty(propKey)?.takeIf { it.isNotBlank() }
        ?: System.getenv(envKey)?.takeIf { it.isNotBlank() }

android {
    namespace = "com.robin.tools_flutter"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.robin.tools_flutter"
        minSdk = 28
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val storePath = propOrEnv("storeFile", "KEYSTORE_PATH")
            val storePassword = propOrEnv("storePassword", "KEYSTORE_PASSWORD")
            val keyAlias = propOrEnv("keyAlias", "KEY_ALIAS")
            val keyPassword = propOrEnv("keyPassword", "KEY_PASSWORD")
            if (storePath != null && storePassword != null && keyAlias != null && keyPassword != null) {
                // Paths in key.properties are relative to android/ unless absolute.
                storeFile = rootProject.file(storePath)
                this.storePassword = storePassword
                this.keyAlias = keyAlias
                this.keyPassword = keyPassword
            }
        }
    }

    buildTypes {
        release {
            val releaseConfig = signingConfigs.getByName("release")
            signingConfig = if (releaseConfig.storeFile != null && releaseConfig.storeFile!!.exists()) {
                releaseConfig
            } else {
                // Local/dev: still buildable; do not ship this artifact to stores.
                signingConfigs.getByName("debug")
            }
            // R8/minify left off until Flutter + FFmpeg keep rules are validated on device.
        }
    }

    packaging {
        jniLibs {
            useLegacyPackaging = true
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(files("libs/ffmpeg-kit.aar"))
    implementation("com.arthenica:smart-exception-java:0.2.1")
    implementation("androidx.core:core-ktx:1.15.0")
}
