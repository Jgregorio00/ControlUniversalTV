# Control Universal TV - compilacion para Android desde Windows.
# Ejecutar después de instalar Android Studio con el Android SDK API 35.
$ErrorActionPreference = 'Stop'
$Project = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Project
Write-Host '=== CONTROL UNIVERSAL TV - CREAR APK ===' -ForegroundColor Cyan

if (-not $env:ANDROID_HOME -and -not $env:ANDROID_SDK_ROOT) {
    $sdk = Join-Path $env:LOCALAPPDATA 'Android\Sdk'
    if (Test-Path $sdk) { $env:ANDROID_HOME = $sdk; $env:ANDROID_SDK_ROOT = $sdk }
}
if (-not $env:ANDROID_HOME -and $env:ANDROID_SDK_ROOT) { $env:ANDROID_HOME = $env:ANDROID_SDK_ROOT }
if (-not $env:ANDROID_SDK_ROOT -and $env:ANDROID_HOME) { $env:ANDROID_SDK_ROOT = $env:ANDROID_HOME }
if (-not $env:ANDROID_HOME -or -not (Test-Path (Join-Path $env:ANDROID_HOME 'platforms\android-35'))) {
    throw 'Falta Android SDK API 35. Abre Android Studio > SDK Manager > instala Android 15.0 (API 35) y Android SDK Build-Tools.'
}
if (-not $env:JAVA_HOME) {
    $jbrs = @(
        (Join-Path $env:ProgramFiles 'Android\Android Studio\jbr'),
        (Join-Path $env:ProgramFiles 'Android\Android Studio\jre')
    )
    foreach ($item in $jbrs) { if (Test-Path (Join-Path $item 'bin\java.exe')) { $env:JAVA_HOME=$item; break } }
}
if (-not $env:JAVA_HOME) { throw 'No se encontró Java. Instala Android Studio (incluye Java Runtime) o configura JAVA_HOME.' }
$env:PATH = (Join-Path $env:JAVA_HOME 'bin') + ';' + $env:PATH
$gradleBin = Join-Path $Project '.local-tools\gradle-8.9\bin\gradle.bat'
if (-not (Test-Path $gradleBin)) {
    $tools = Join-Path $Project '.local-tools'
    New-Item -ItemType Directory -Path $tools -Force | Out-Null
    $zip = Join-Path $tools 'gradle-8.9-bin.zip'
    Write-Host 'Descargando Gradle oficial (solo la primera vez)...' -ForegroundColor Yellow
    Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-8.9-bin.zip' -OutFile $zip -UseBasicParsing
    Write-Host 'Extrayendo Gradle...'
    Expand-Archive -Path $zip -DestinationPath $tools -Force
    Remove-Item $zip
}
Write-Host 'Compilando el APK...' -ForegroundColor Cyan
& $gradleBin --no-daemon ':app:assembleDebug'
if ($LASTEXITCODE -ne 0) { throw 'Compilación fallida. Revisa los errores mostrados en la terminal.' }
$source = Join-Path $Project 'app\build\outputs\apk\debug\app-debug.apk'
$destination = Join-Path $Project 'ControlUniversalTV_NIKKEL_Samsung.apk'
Copy-Item $source $destination -Force
Write-Host ''
Write-Host "APK GENERADO: $destination" -ForegroundColor Green
Write-Host 'Cópialo al celular Android e instálalo. Autoriza la instalación de apps desde archivos si te lo solicita.'
