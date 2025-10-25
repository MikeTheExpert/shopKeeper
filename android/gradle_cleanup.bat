@echo off
title Safe Gradle Cleanup
echo ============================================
echo   SAFE GRADLE CLEANUP - ANDROID STUDIO
echo ============================================
echo.

REM ====== 1. Close Android Studio Reminder ======
echo Please make sure Android Studio is CLOSED before continuing.
pause

REM ====== 2. Delete per-project build folders ======
echo Deleting all "build" folders in project...
for /d /r "%~dp0" %%d in (build) do (
    if exist "%%d" rd /s /q "%%d"
)
echo Done.
echo.

REM ====== 3. Delete project-specific .gradle folder ======
if exist "%~dp0.gradle" (
    echo Removing project .gradle folder...
    rd /s /q "%~dp0.gradle"
    echo Done.
) else (
    echo No project .gradle folder found.
)
echo.

REM ====== 4. Trim global Gradle cache (keep modules-2) ======
set "GRADLE_CACHE=%USERPROFILE%\.gradle\caches"
if exist "%GRADLE_CACHE%" (
    echo Cleaning global Gradle cache except modules-2...
    pushd "%GRADLE_CACHE%"
    for /d %%d in (*) do (
        if /I not "%%d"=="modules-2" rd /s /q "%%d"
    )
    popd
    echo Done.
) else (
    echo No global Gradle cache found.
)
echo.

REM ====== 5. Remove old Gradle daemons ======
if exist "%USERPROFILE%\.gradle\daemon" (
    echo Removing old Gradle daemons...
    rd /s /q "%USERPROFILE%\.gradle\daemon"
    echo Done.
) else (
    echo No Gradle daemon folder found.
)
echo.

REM ====== 6. Clean Android build cache ======
if exist "%~dp0gradlew.bat" (
    echo Running Gradle build cache clean...
    call gradlew cleanBuildCache
) else (
    echo gradlew not found in project folder. Skipping build cache clean.
)
echo.

echo ============================================
echo Cleanup complete! You just freed up space.
echo ============================================
pause
