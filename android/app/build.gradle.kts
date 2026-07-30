import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keyPropertiesFile = rootProject.file("key.properties")
val keyProperties = Properties()
keyProperties.load(FileInputStream(keyPropertiesFile))

android {
    namespace = "com.jileduo.finance"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.jileduo.finance"
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
        ndk {
            abiFilters += setOf("armeabi-v7a", "arm64-v8a")
        }
    }

    signingConfigs {
        create("release") {
            keyAlias = keyProperties["keyAlias"] as String
            keyPassword = keyProperties["keyPassword"] as String
            storeFile = file(keyProperties["storeFile"] as String)
            storePassword = keyProperties["storePassword"] as String
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        debug {
            // 调试包也用 release 签名(jileduo.jks),与上线包指纹一致,
            // 便于穿山甲等联盟后台只登记一把签名即可通过校验
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    // 芒果聚合 SDK 全平台 AAR（libs/**/*.aar）
    implementation(fileTree(mapOf("dir" to "libs", "include" to listOf("**/*.aar", "**/*.jar"))))

    // ---- 芒果聚合各广告平台所需的远程依赖（对照官方 v3.1.8.5 接入文档 / demo）----
    implementation("androidx.multidex:multidex:2.0.1")

    // 通用 / 广点通 / 百度
    implementation("com.squareup.okhttp3:okhttp:3.12.1")
    implementation("com.squareup.okhttp3:logging-interceptor:3.12.0")
    implementation("com.google.code.gson:gson:2.8.5")
    implementation("com.googlecode.android-query:android-query:0.25.9")
    implementation("com.github.bumptech.glide:glide:4.8.0")
    implementation("commons-codec:commons-codec:1.15")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("androidx.recyclerview:recyclerview:1.3.1")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    implementation("androidx.localbroadcastmanager:localbroadcastmanager:1.1.0")
    implementation("androidx.cardview:cardview:1.0.0")

    // 华为（远程引入）
    implementation("com.huawei.hms:ads-lite:13.4.74.302")

    // 优推：exoplayer
    implementation("com.google.android.exoplayer:exoplayer-core:2.13.3")
    implementation("com.google.android.exoplayer:exoplayer-ui:2.13.3")

    // 快手（旧 support 由 jetifier 迁移到 AndroidX）
    implementation("com.android.support:design:28.0.0")

    // OPPO
    implementation("androidx.legacy:legacy-support-v4:1.0.0")
    implementation("androidx.palette:palette:1.0.0")
    implementation("com.squareup.okio:okio:2.5.0")
    implementation("org.jetbrains.kotlin:kotlin-android-extensions-runtime:1.3.72")

    // 多盟：微信（可选，提升广告效果；如与业务冲突可自行调整版本）
    implementation("com.tencent.mm.opensdk:wechat-sdk-android-without-mta:5.5.8")
}

flutter {
    source = "../.."
}
